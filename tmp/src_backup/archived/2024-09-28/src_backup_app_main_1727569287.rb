def tick args
  if Kernel.tick_count == 0
    wave_data = generate_sine_wave frequency: 440.0,
                                   duration: 60 * 1.5,
                                   fade_out: true
    args.audio[:my_audio] = {
      input: [1, 48000, wave_data],
    }
  end
  
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