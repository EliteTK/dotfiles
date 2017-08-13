vis.events.subscribe(vis.events.WIN_OPEN, function(win)
   if win.syntax then
      ftmodule = 'ftplugin/'..win.syntax
      if vis:module_exist(ftmodule) then require(ftmodule)(win) end
   end
end)
