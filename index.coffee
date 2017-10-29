fs = require 'fs'
path = require 'path'

module.exports = (robot, scripts) ->
  scriptsPath = path.resolve(__dirname, 'src')
  if fs.existsSync scriptsPath
    for script in fs.readdirSync(scriptsPath).sort()
      if scripts? and '*' not in scripts
        robot.loadFile(scriptsPath, script) if script in scripts
      else
        robot.loadFile(scriptsPath, script)

  github = require 'octonode'

  githubTokenForUser = (msg) ->
    user = robot.brain.userForId msg.envelope.user.id
    token = robot.vault.forUser(user).get(robot.vault.key)
    return token if token?
    msg.reply "I don't know your GitHub token. \nPlease generate one with the \"repo\" scope on https://github.com/settings/tokens and set it in a private message to me with the command: \"github token set <github_personal_access_token>\""

  robot.ghscrum =
      status: (msg, id, repo) ->
         token = githubTokenForUser msg
         if token?
          client = github.client token
          issue = client.issue repo, id
          issue.info (err, data, headers) ->
            unless err?
              msg.reply "Issue ##{id} in #{repo} - #{data.title} - #{data.html_url}"
            else
              msg.reply "Error from GitHub API: #{err.body.message}"
              return err
