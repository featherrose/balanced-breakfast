function onPlayerAction(player, action, targets)
    for targetIndex,entry in pairs(targets) do
      if entry.getGUID() == self.getGUID() then
        -- Objects being targeted include this object.
        if action == Player.Action.FlipOver then
          -- Player is flipping this object.
          Global.call("setFlailingMode", {
            --newMode = newMode, -- boolean; optional, defaults to false unless toggle is supplied
            toggle = true, -- boolean; optional, defaults to true if neither it nor newMode is not supplied
            playerColor = player.color, -- string; optional, defaults to "Grey"
          })
        end -- end 'if action == Player.Action.FlipOver ...'
      end -- end 'if entry.getGUID() == self.getGUID()'
    end -- end 'for i,entry in pairs(targets)'
  return true
end -- end onPlayerAction

function onDestroy()
  Global.call("setFlailingMode", {
    newMode = false, -- boolean; optional, defaults to false unless toggle is supplied
    --toggle = true, -- boolean; optional, defaults to true if neither it nor newMode is not supplied
    --playerColor = player.color, -- string; optional, defaults to "Grey"
  })
end -- end onDestroy