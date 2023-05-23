local select_layout = function(builtin, opts)
  if not opts then
    opts = {}
  end

  opts.layout_strategy = "vertical"

  opts.path_display = function(_, path)
    return require("path").format(path)
  end

  return function()
    builtin(opts)
  end
end

return {select_layout = select_layout}
