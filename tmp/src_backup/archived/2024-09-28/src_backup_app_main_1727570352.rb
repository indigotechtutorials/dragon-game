def tick args
  args.state.world.w      ||= 1280
  args.state.world.h      ||= 720
  args.outputs[:scene].transient!
  args.outputs[:scene].w = args.state.world.w
  args.outputs[:scene].h = args.state.world.h

  args.outputs[:scene].sprites << { 
    x: 0,
    y: 0,
    w: 1280,
    h: 720,
    path: "sprites/background/plx-1.png"
  }

  args.outputs[:scene].sprites << { 
    x: 0,
    y: 0,
    w: 1280,
    h: 720,
    path: "sprites/background/plx-2.png"
  }

  args.outputs[:scene].sprites << { 
    x: 0,
    y: 0,
    w: 1280,
    h: 720,
    path: "sprites/background/plx-3.png"
  }

  if args.inputs.keyboard.m
    wave_data = generate_sine_wave frequency: 432.0,
                                   duration: 300,
                                   fade_out: true
    args.audio[:audio1] = {
      input: [1, 48000, wave_data],
    }

    wave_data = generate_sine_wave frequency: 433.0,
                                   duration: 300,
                                   fade_out: true
    args.audio[:audio2] = {
      input: [1, 48000, wave_data],
    }
  end

  args.outputs[:scene].labels << { 
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

  args.outputs[:scene].sprites << args.state.dragon
  
  # Render the world

  args.outputs.sprites << {
    x: 0,
    y: 0,
    w: args.state.world.w,
    w: args.state.world.half
    path: :scene
  }

  frame_index = 0.frame_index 6, 10, true

  args.state.dragon.path = "sprites/misc/dragon-#{frame_index}.png"

  if args.inputs.right
    args.state.dragon.x += 5
    args.state.dragon.flip_horizontally = false
  end

  if args.inputs.left
    args.state.dragon.x -= 5
    args.state.dragon.flip_horizontally = true
  end
end

def generate_sine_wave frequency:, duration:, fade_out: true
  samples_per_period = (48000 / frequency).ceil
  count = (samples_per_period * duration.fdiv(60)).floor * frequency
  count.map_with_index do |i|
    attack_perc = (i / samples_per_period).clamp(0, 1)
    release_perc = if fade_out
                      1 - (i / count)
                   elsif i > count - samples_per_period
                     (count - i) / samples_per_period
                   else
                     1
                   end
    Math.sin((2 * Math::PI) * (i / samples_per_period)) * attack_perc * release_perc
  end
end