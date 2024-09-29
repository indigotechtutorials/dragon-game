def tick args
  args.outputs.labels << { 
    x: 500, 
    y: 550,
    text: "DragonFM",
    size_enum: 10,
  }

  args.outputs.sprites << {
    x: 500,
    y: 300,
    w: 200,
    h: 200,
    path: "sprites/misc/dragon-0.png"
  }
end
