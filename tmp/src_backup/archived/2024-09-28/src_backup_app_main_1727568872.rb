def tick args
  args.outputs.labels << { 
    x: 500, 
    y: 550,
    text: "DragonFM",
    size_enum: 10,
  }

  args.outputs.sprites << {
    x: 400,
    y: 300,
    w: 250,
    h: 250,
    path: "sprites/misc/dragon-0.png"
  }
end
