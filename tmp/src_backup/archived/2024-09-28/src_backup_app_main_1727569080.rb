def tick args
  args.outputs.labels << { 
    x: 500, 
    y: 550,
    text: "DragonFM",
    size_enum: 10,
  }

  args.state.dragon ||= {
    x: 450,
    y: 300,
    w: 200,
    h: 200,
    path: "sprites/misc/dragon-0.png"
  }

  args.outputs.sprites << args.state.dragon

  frame_index = 0.frame_index 6, 10, true

  args.state.dragon.path = "sprites/misc/dragon-#{frame_index}.png"

  if args.inputs.right
    args.state.dragon.x += 5
  end
end
