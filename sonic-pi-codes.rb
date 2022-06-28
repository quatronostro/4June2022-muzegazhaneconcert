#BUFFER 1--------------------------------------------------------------

use_debug false
use_sched_ahead_time 1
use_bpm 138
set(:bpm, current_bpm)
set(:stop, false)


set_mixer_control! lpf_slide: 1, lpf: 120
set_mixer_control! hpf_slide: 1, hpf: 10

master = (ramp *range(0, 1, 0.01))
fadein = (ramp *range(0, 1, 0.0001))

tracker = [0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0]


define :start_loop do |i|
  tracker[i] = 1
end


define :stop_loop do |i|
  tracker[i] = 0
end

define :stop_all do
  tracker[0] = 0
  tracker[1] = 0
  tracker[2] = 0
  tracker[3] = 0
  tracker[4] = 0
  tracker[5] = 0
  tracker[6] = 0
  tracker[7] = 0
  tracker[8] = 0
  tracker[9] = 0
  tracker[10] = 0
  tracker[11] = 0
  tracker[12] = 0
  tracker[13] = 0
  tracker[14] = 0
  tracker[15] = 0
  tracker[16] = 0
  tracker[17] = 0
  tracker[18] = 0
  tracker[19] = 0
  tracker[20] = 0
  tracker[21] = 0
  tracker[22] = 0
  tracker[23] = 0
  tracker[24] = 0
  tracker[25] = 0
  tracker[26] = 0
  tracker[27] = 0
  tracker[28] = 0
end

live_loop :bar do
  use_bpm get(:bpm)
  sleep 1
end

live_loop :beats do
  sync :bar
  sleep 4
  cue :bass
end

define :pattern do |pattern|
  return pattern.ring.tick == "x"
end

def play_the_blades(synth_name)
  use_synth synth_name
  play :c2, cutoff: (line 60, 100, steps: 360).mirror.tick,
    attack: 0.03, divisor: line(0, 1, steps: 100).mirror.tick,
    depth: rrand(2, 2.5), amp: 0.9,
    res: line(0, 0.4, steps: 520).mirror.tick,
    pan: rrand(-0.5, 0.5)
  sleep (ring 0.75, 0.75, 0.75, 0.75, 1.25).tick
end



live_loop :kick1, sync: :bar do
  if tracker[1]>0 then
    ##| a = 0.89 * master.look
    sample :bd_kick, amp: 1.5
    sleep 1
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.356, room: 0.289 do
  live_loop :grov1, sync: :bar do
    if tracker[2]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/Drum1.wav", amp: 1.2
      sleep 16
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.456, room: 0.789 do
  live_loop :grov2, sync: :bar do
    if tracker[3]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/Drum2.wav", amp: 1.1
      sleep 16
    else
      sleep 1
    end
  end
end

live_loop :hat1, sync: :bar do
  if tracker[4]>0 then
    sleep 0.5
    sample "C:/Users/Berke/Music/Glitch With Friends+/Drums/Hats and Miscellaneous Percussion/CLAUDE - hat01.wav"
    sleep 0.5
  else
    sleep 1
  end
end

live_loop :bassımıssı, sync: :bar do
  if tracker[5]>0 then
    ##| tick
    sample "C:/Users/Berke/Music/Glitch With Friends+/Glitch Noises/oddlogic - selfosc_9.wav",
      cutoff: line(10, 100, steps: 100).mirror.tick,
      amp: 1.3
    sleep 2
  else
    sleep 1
  end
  ##| tick
end

synth_mix = 1
synths = [:rodeo, :fm, :tb303]
with_fx :reverb, mix: line(0.15, 0.7, steps: 280).mirror.look, room: 0.678 do
  with_fx :ixi_techno, mix: line(0, 0.5, steps: 250).mirror.look, cutoff_max: 0.3 do
    with_fx :tanh, krunch: line(0, 1.2, steps: 160).mirror.look do
      ##| with_fx :lpf, cutoff: line(60, 110, steps: 523).mirror.look do
      live_loop :do, sync: :bar do
        if tracker[6]>0 then
          synth_name = synths[rand(3)].to_sym()
          play_the_blades(synth_name)
        else
          sleep 1
        end
      end
    end
  end
end
##| end

live_loop :fx, sync: :bar do
  ##| stop
  if tracker[7]>0 then
    with_fx :slicer, phase: 0.75, decay: 12 do
      with_fx :reverb, mix: 0.44, room: 0.88 do
        2.times do
          sample "C:/Users/Berke/Music/moth/s_r.wav",
            amp: 2.5, cutoff: rrand(110, 80), attack: 2, decay: 0.5
          sleep 48
        end
        ##| sleep 240
      end
    end
  else
    sleep 1
  end
  tick
end

live_loop :hihat2, sync: :bar do
  if tracker[8]>0 then
    a = 0.7 #* fadein.tick
    sample "C:/Users/Berke/Music/Glitch With Friends+/Drums/Hats and Miscellaneous Percussion/CLAUDE - hat16.wav",
      cutoff: 100, amp: a if pattern "--xx"
    sleep 0.25
  else
    sleep 1
  end
end

with_fx :echo, phase: 1, mix: 1, decay: 5 do
  with_fx :reverb, mix: 0.455, room: 0.234 do
    with_fx :nbpf, amp: 0.2 do
      live_loop :melodyms, sync: :bar do
        if tracker[9]>0 then
          16.times do
            play scale(:c4, :iwato).choose, amp: 1 * fadein.tick,
              pan: rrand(-0.8, 0.8)
            sleep 0.25
          end
          sleep 8
        else
          sleep 1
        end
      end
    end
  end
end

live_loop :control, sync: :bar do
  cp = ['c3'].tick(:cp)
  tone = ['m'].tick(:tn)
  sc = 'iwato'
  set :cp, cp
  set :tone, tone
  set :sc, sc
  sleep 16
end

with_fx :echo, decay: 5, phase: 1 do
  with_fx :reverb, room: 0.8 do
    with_fx :nbpf, amp: 0.089 do
      live_loop :gr, sync: :bar do
        if tracker[10]>0 then
          4.times do
            
            cp = get(:cp)
            sc = get(:sc)
            
            n = [0,0,0,1].look(:n2)
            n2 = [5,0,0,7, 3,0,0,1, 0,5,0,1, 0,0,0,1].tick(:n2)
            
            notes = scale(cp, sc).shuffle.tick(:notes)
            notes2 = scale(cp, sc).shuffle.tick(:notes2)
            notes3 = scale(cp, sc)[n]
            notes4 = scale(cp, sc)[n2]
            
            num = rrand_i(0, 64)
            num2 = rrand_i(0, 64)
            
            if spread(11, 16).rotate(num2).tick(:fm1)
              synth :fm,
                note: notes2 + choose([12, 24]),
                depth: 1, divisor: 1, amp: 1 * fadein.tick,
                amp_slide: 16, release: 0.1
            end
            sleep 0.25
          end
        else
          sleep 1
        end
      end
    end
  end
end

with_fx :reverb, mix: 0.456, room: 0.789 do
  live_loop :grov3, sync: :bar do
    stop if get(:stop)
    if tracker[11]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/Drum2trans.wav", amp: 1.1
      sleep 64
      set(:stop, true)
    else
      sleep 1
    end
  end
end


live_loop :fm1, sync: :bar do
  if tracker[12]>0 then
    with_fx :reverb, mix: 0.3, room: 0.68 do
      with_fx :echo, phase: 1, decay: 4 do
        sample "C:/Users/Berke/Music/AbleforSonic/fm8.2.wav", onset: rrand(5, 19), amp: 2 * master.tick
        sleep 4
      end
    end
  else
    sleep 1
  end
end

live_loop :fm2, sync: :bar do
  if tracker[13]>0 then
    sample "C:/Users/Berke/Music/AbleforSonic/fm8.2.wav"
    sleep 32
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.48, room: 0.69 do
  live_loop :fm3rise, sync: :bar do
    if tracker[14]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/fm8.3.wav"
      sleep 16
    else
      sleep 1
    end
  end
end

live_loop :br, sync: :bar do
  if tracker[15]>0 then
    sample "C:/Users/Berke/Music/AbleforSonic/bassrtm.wav", amp: 1.3
    sleep 8
  else
    sleep 1
  end
end

live_loop :snrr, sync: :bar do
  if tracker[16]>0 then
    sample "C:/Users/Berke/Music/AbleforSonic/snarertm.wav", amp: 0.7
    sleep 32
  else
    sleep 1
  end
end

live_loop :hhr, sync: :bar do
  if tracker[17]>0 then
    sample "C:/Users/Berke/Music/AbleforSonic/hhrtm.wav"
    sleep 8
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.7, room: 0.8 do
  live_loop :cymr, sync: :bar do
    if tracker[18]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/cymrtm.wav", amp: 0.7
      sleep 8
    else
      sleep 1
    end
  end
end

live_loop :kick2, sync: :bar do
  if tracker[19]>0 then
    ##| a = 0.89 * master.look
    sample :bd_haus, amp: 1.5
    sleep 1
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.679, room: line(0.9, 0.3, steps: 20).mirror.look do
  live_loop :ambi1, sync: :bar do
    if tracker[20]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/ambi1.wav",
        hpf: 40, cutoff: rrand(110, 125), amp: rrand(0.5, 0.8)
      sleep 40
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.379, room: 0.470 do
  live_loop :highmelo, sync: :bar do
    if tracker[21]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/fm8.4.wav",
        amp: 3 * master.tick
      sleep 16
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.479, room: 0.499 do
  live_loop :fmrtmm, sync: :bar do
    if tracker[22]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/fm8.5.wav",
        amp: 2.5 * master.tick, cutoff: 115
      sleep 16
    else
      sleep 1
    end
  end
end

with_fx :tanh, krunch: 0.5 do
  with_fx :reverb, mix: 0.379, room: 0.470 do
    live_loop :highmelo2, sync: :bar do
      if tracker[24]>0 then
        sample "C:/Users/Berke/Music/AbleforSonic/fm8.4.wav",
          amp: 1.8, onset: 13
        sleep 4
      else
        sleep 1
      end
    end
  end
end


with_fx :reverb, mix: 0.256, room: 0.569 do
  live_loop :fmbbox, sync: :bar do
    if tracker[23]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/bbox.wav",
        amp: 1.3, cutoff: 100
      sleep 16
    else
      sleep 1
    end
  end
end

live_loop :sn, sync: :bar do
  if tracker[26]>0 then
    sleep 1
    sample :sn_dolf, cutoff: 100
    sleep 1
  else
    sleep 1
  end
end

live_loop :kickrtm, sync: :bar do
  if tracker[25]>0 then
    a = 0.5
    sample :bd_kick,
      amp: a if pattern "x--x--x-x--x--x-"
    sleep 0.25
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.256, room: 0.769 do
  live_loop :ambi2, sync: :bar do
    if tracker[27]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/ambi2.wav",
        amp: 0.59, cutoff: rrand(110, 100)
      sleep 64
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.356, room: 0.669 do
  live_loop :ambi3, sync: :bar do
    if tracker[28]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/ambi3.wav",
        amp: 0.99, cutoff: rrand(120, 100)
      sleep 64
    else
      sleep 1
    end
  end
end



#SCRIPTSSSSS111111111111111111111111111111111111

sleep 250
start_loop 5 #basımsı
sleep 24
start_loop 3 #grov2
sleep 8
start_loop 27
sleep 8
start_loop 2 #grov1
sleep 16
set_mixer_control! hpf_slide: 1, hpf: 40
start_loop 25 #kick
sleep 32
start_loop 4 #hh
sleep 32
stop_loop 25 #kick
stop_loop 5 #basımsı
set_mixer_control! hpf_slide: 1, hpf: 70
sleep 8
start_loop 25 #kick
start_loop 5 #basımsı
set_mixer_control! hpf_slide: 1, hpf: 10
sleep 32
start_loop 20
sleep 16
start_loop 6 #do
start_loop 7 #fx
stop_loop 25 #kick
stop_loop 5
sleep 32
start_loop 1
stop_loop 4
sleep 64
start_loop 4
stop_loop 3
sleep 32
set_mixer_control! lpf_slide: 16, lpf: 40
sleep 32
stop_loop 1
stop_loop 6
stop_loop 5
set_mixer_control! lpf_slide: 1, lpf: 120
start_loop 9
sleep 64
set_mixer_control! hpf_slide: 16, hpf: 100
start_loop 21
start_loop 8
sleep 32
set_mixer_control! hpf_slide: 1, hpf: 10
stop_loop 20
start_loop 1
start_loop 6
start_loop 3
sleep 64
stop_loop 8
stop_loop 4
sleep 32
stop_loop 6
start_loop 10
sleep 32
stop_loop 3
start_loop 11
stop_loop 9
set_mixer_control! hpf_slide: 1, hpf: 70
sleep 64
set_mixer_control! hpf_slide: 1, hpf: 10
start_loop 9 #kick
start_loop 3
start_loop 5
start_loop 4
sleep 32
stop_loop 1
start_loop 23
sleep 8
start_loop 1
stop_loop 3
stop_loop 2
sleep 64
stop_loop 1
start_loop 12
start_loop 13
stop_loop 3
sleep 32
start_loop 14
stop_loop 2
sleep 16
start_loop 15
start_loop 28
stop_loop 10
stop_loop 11
sleep 16
stop_loop 23
start_loop 19
stop_loop 27
stop_loop 9
stop_loop 5
stop_loop 4
stop_loop 10
sleep 32
stop_loop 19
start_loop 18
start_loop 22
sleep 16
start_loop 19
stop_loop 18
sleep 32
start_loop 17
sleep 1
start_loop 24
sleep 32
stop_loop 15
stop_loop 14
stop_loop 19
start_loop 16
set_mixer_control! hpf_slide: 32, hpf: 90
sleep 64
set_mixer_control! hpf_slide: 1, hpf: 10
stop_loop 16
stop_loop 21
start_loop 19
start_loop 23
start_loop 4
sleep 48
stop_loop 19
stop_loop 4
start_loop 26
set_mixer_control! hpf_slide: 8, hpf: 95
sleep 16
set_mixer_control! hpf_slide: 1, hpf: 10
start_loop 19
stop_loop 12
sleep 16
stop_loop 13
sleep 16
stop_loop 26
sleep 16
stop_loop 24
sleep 16
stop_loop 17
sleep 16
stop_loop 24
sleep 8
stop_loop 23
sleep 8
stop_loop 22
sleep 16
stop_loop 19
stop_all


#BUFFER 2--------------------------------------------------------------
  
  
  
use_debug false
use_sched_ahead_time 1
use_bpm 140
set(:bpm, current_bpm)
set(:stop, false)


set_mixer_control! lpf_slide: 1, lpf: 120
set_mixer_control! hpf_slide: 1, hpf: 10

master = (ramp *range(0, 2, 0.01))
fadein = (ramp *range(0, 1, 0.0001))

tracker = [0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0]


define :start_loop do |i|
  tracker[i] = 1
end


define :stop_loop do |i|
  tracker[i] = 0
end

define :stop_all do
  tracker[0] = 0
  tracker[1] = 0
  tracker[2] = 0
  tracker[3] = 0
  tracker[4] = 0
  tracker[5] = 0
  tracker[6] = 0
  tracker[7] = 0
  tracker[8] = 0
  tracker[9] = 0
  tracker[10] = 0
  tracker[11] = 0
  tracker[12] = 0
  tracker[13] = 0
  tracker[14] = 0
  tracker[15] = 0
  tracker[16] = 0
  tracker[17] = 0
  tracker[18] = 0
  tracker[19] = 0
  tracker[20] = 0
  tracker[21] = 0
  tracker[22] = 0
  tracker[23] = 0
  tracker[24] = 0
  tracker[25] = 0
end

live_loop :bar do
  use_bpm get(:bpm)
  sleep 1
end

live_loop :beats do
  sync :bar
  sleep 4
  cue :bass
end

define :pattern do |pattern|
  return pattern.ring.tick == "x"
end


with_fx :reverb, mix: 0.356, room: 0.289 do
  live_loop :tran1, sync: :bar do
    if tracker[0]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/bassrtm2.wav"
      sleep 16
    else
      sleep 1
    end
  end
end

with_fx :flanger, feedback: 0.5, invert_flange: 1 do
  with_fx :reverb, mix: 0.356, room: 0.389 do
    live_loop :tran2, sync: :bar do
      if tracker[1]>0 then
        sample "C:/Users/Berke/Music/AbleforSonic/new1.wav", cutoff: rrand(90, 100)
        sleep 32
      else
        sleep 1
      end
    end
  end
end

live_loop :kickrtm2, sync: :bar do
  if tracker[2]>0 then
    a = 0.5
    sample :bd_haus,
      amp: a if pattern "x--x--x-x--x--x-"
    sleep 0.25
  else
    sleep 1
  end
end


live_loop :hhh1, sync: :bar do
  if tracker[3]>0 then
    sample "C:/Users/Berke/Music/Glitch With Friends+/Drums/Hats and Miscellaneous Percussion/CLAUDE - hat06.wav"
    sleep 0.25
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.356, room: 0.489 do
  live_loop :tizrtm1, sync: :bar do
    if tracker[4]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/tizrtm.wav", amp: 1.2
      sleep 64
    else
      sleep 1
    end
  end
end


live_loop :noih, sync: :bar do
  if tracker[5]>0 then
    use_synth :noise
    with_fx :reverb, mix: 0.3 do
      sleep 0.5
      play :e6, amp: 0.38, release: 0.3, cutoff: 105
      sleep 0.5
    end
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.256, room: 0.389 do
  live_loop :tizs1, sync: :bar do
    if tracker[6]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/saykotiz.wav", amp: 1.8
      sleep 32
    else
      sleep 1
    end
  end
end

live_loop :kick22, sync: :bar do
  if tracker[7]>0 then
    sample :bd_haus, amp: 0.6
    sample :bd_klub, amp: 1.2
    sleep 1
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.256, room: 0.189 do
  live_loop :hayhet1, sync: :bar do
    if tracker[8]>0 then
      a = 0.59
      sample "C:/Users/Berke/Music/Glitch With Friends+/Drums/Hats and Miscellaneous Percussion/CLAUDE - hat12.wav",
        amp: a if pattern "-x-x-xx---xxxx"
      sleep 0.25
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.256, room: 0.289 do
  live_loop :bassı2, sync: :bar do
    if tracker[9]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/bass1.wav", amp: 1.9
      sleep 64
    else
      sleep 1
    end
  end
end


with_fx :reverb, mix: 0.256, room: 0.389 do
  live_loop :rtm2, sync: :bar do
    if tracker[10]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/ritm1.wav", amp: 1.9
      sleep 32
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.256, room: 0.289 do
  live_loop :fmmmmm, sync: :bar do
    if tracker[11]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/fm8.6.wav", amp: 1.8
      sleep 32
    else
      sleep 1
    end
  end
end

live_loop :kick33, sync: :bar do
  if tracker[12]>0 then
    sample :bd_haus, amp: 1.3
    sleep 1
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.056, room: 0.089 do
  live_loop :basss2, sync: :bar do
    if tracker[13]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/bass2.wav", amp: 1.7
      sleep 32
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.356, room: 0.189 do
  live_loop :clap11, sync: :bar do
    if tracker[14]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/clap1.wav"
      sleep 16
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.256, room: 0.289 do
  live_loop :fmmmmm2, sync: :bar do
    if tracker[15]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/fm8.7.wav", amp: 1.5
      sleep 32
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.256, room: 0.289 do
  live_loop :fmmmmm3, sync: :bar do
    if tracker[16]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/fm8.8.wav", amp: 1.3
      sleep 64
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.456, room: 0.489 do
  live_loop :hayhet2, sync: :bar do
    if tracker[17]>0 then
      sleep 0.5
      sample "C:/Users/Berke/Music/Glitch With Friends+/Drums/Hats and Miscellaneous Percussion/CLAUDE - hat12.wav",
        amp: 0.8, cutoff: 110
      sleep 0.5
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.456, room: 0.789 do
  live_loop :fmmmmm4, sync: :bar do
    if tracker[18]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/fm8.9.wav", amp: 1.9
      sleep 32
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.256, room: 0.289 do
  live_loop :rrttmm4, sync: :bar do
    if tracker[19]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/ritm2.wav", amp: 1.4, cutoff: rrand(110, 120)
      sleep 32
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.156, room: 0.189 do
  live_loop :rrttmm5, sync: :bar do
    if tracker[21]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/ritm3.wav", amp: 1.7
      sleep 8
    else
      sleep 1
    end
  end
end


live_loop :kickrtm4, sync: :bar do
  if tracker[20]>0 then
    a = 1.3
    sample :bd_haus,
      amp: a if pattern "x---x---x---x---x---x---x---x-x-"
    sleep 0.25
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.156, room: 0.589 do
  live_loop :extrarttmm, sync: :bar do
    if tracker[22]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/exrtim.wav", amp: 1.5
      sleep 32
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.156, room: 0.289 do
  live_loop :clshh, sync: :bar do
    if tracker[23]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/hhclosed.wav", amp: 1.2, cutoff: 110
      sleep 8
    else
      sleep 1
    end
  end
end



#SCRIPTTTTTTT222222222222222222


start_loop 0
sleep 64
start_loop 1
sleep 64
start_loop 2 #kick
sleep 64
start_loop 3 #hihat
sleep 32
stop_loop 0
stop_loop 2
set_mixer_control! hpf_slide: 16, hpf: 95
sleep 32
start_loop 0
start_loop 2
stop_loop 1
set_mixer_control! hpf_slide: 1, hpf: 10
sleep 16
start_loop 4 #tizritm
stop_loop 3
sleep 32
start_loop 5 #noihh
sleep 64
set_mixer_control! hpf_slide: 32, hpf: 105
stop_loop 2 #kick
start_loop 6 #tiz do si
sleep 64
stop_loop 5
set_mixer_control! hpf_slide: 1, hpf: 10
stop_loop 0
stop_loop 6
start_loop 7 #kick2
start_loop 3 #hihat kısa
start_loop 9 #bass
sleep 16
stop_loop 4
start_loop 8 #hihat yeni ritm ile
sleep 32
set_mixer_control! hpf_slide: 1, hpf: 80
stop_loop 9
sleep 8
set_mixer_control! hpf_slide: 1, hpf: 10
start_loop 9
start_loop 5
sleep 64
stop_loop 7
start_loop 10 #parcussive ritm
sleep 32
start_loop 7
stop_loop 5
sleep 16
start_loop 3
sleep 32
stop_loop 7
start_loop 11 #melodi
set_mixer_control! hpf_slide: 32, hpf: 88
sleep 64
set_mixer_control! hpf_slide: 1, hpf: 10
stop_loop 8
start_loop 12 #kickhard
stop_loop 3
stop_loop 5
stop_loop 9
sleep 32
start_loop 13 #bass2
stop_loop 9
sleep 16
start_loop 14 #clap
sleep 16
start_loop 3 #shorthh
sleep 32
stop_loop 12
start_loop 0
sleep 16
start_loop 12
stop_loop 0
sleep 32
stop_loop 12
sleep 8
start_loop 15
stop_loop 11
stop_loop 13
start_loop 12
start_loop 8
sleep 64
stop_loop 15
stop_loop 12
stop_loop 14
stop_loop 3
sleep 16
start_loop 16
set_mixer_control! hpf_slide: 16, hpf: 67
sleep 16
set_mixer_control! hpf_slide: 1, hpf: 10
start_loop 12
stop_loop 8
sleep 32
start_loop 17
stop_loop 10
sleep 32
set_mixer_control! lpf_slide: 32, lpf: 50
sleep 32
set_mixer_control! lpf_slide: 1, lpf: 120
start_loop 18
stop_loop 11
stop_loop 17
stop_loop 12
start_loop 4
stop_loop 16
sleep 16
start_loop 2
sleep 80
stop_loop 2
set_mixer_control! hpf_slide: 16, hpf: 67
sleep 32
set_mixer_control! hpf_slide: 1, hpf: 10
stop_loop 4
start_loop 19
sleep 16
start_loop 21
set_mixer_control! hpf_slide: 16, hpf: 85
sleep 32
set_mixer_control! hpf_slide: 1, hpf: 10
start_loop 20 #new kick
sleep 32
start_loop 23
sleep 64
start_loop 22
sleep 32
stop_loop 18
sleep 32
stop_loop 19
sleep 32
stop_loop 20
sleep 16
stop_loop 21
sleep 16
stop_loop 23
sleep 96
stop_loop 22



#BUFFER 3--------------------------------------------------------------


  use_debug false
use_sched_ahead_time 1
use_bpm 142
set(:bpm, current_bpm)
set(:stop, false)


set_mixer_control! lpf_slide: 1, lpf: 120
set_mixer_control! hpf_slide: 1, hpf: 10

master = (ramp *range(0, 2, 0.01))
fadein = (ramp *range(0, 1, 0.0001))

tracker = [0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0,
           0, 0, 0, 0]


define :start_loop do |i|
  tracker[i] = 1
end


define :stop_loop do |i|
  tracker[i] = 0
end

define :stop_all do
  tracker[0] = 0
  tracker[1] = 0
  tracker[2] = 0
  tracker[3] = 0
  tracker[4] = 0
  tracker[5] = 0
  tracker[6] = 0
  tracker[7] = 0
  tracker[8] = 0
  tracker[9] = 0
  tracker[10] = 0
  tracker[11] = 0
  tracker[12] = 0
  tracker[13] = 0
  tracker[14] = 0
  tracker[15] = 0
  tracker[16] = 0
  tracker[17] = 0
  tracker[18] = 0
  tracker[19] = 0
  tracker[20] = 0
  tracker[21] = 0
  tracker[22] = 0
  tracker[23] = 0
  tracker[24] = 0
  tracker[25] = 0
end

live_loop :bar do
  use_bpm get(:bpm)
  sleep 1
end

live_loop :beats do
  sync :bar
  sleep 4
  cue :bass
end

define :pattern do |pattern|
  return pattern.ring.tick == "x"
end


with_fx :reverb, mix: 0.256, room: 0.289 do
  live_loop :br1, sync: :bar do
    if tracker[0]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/breakbeat1.wav", amp: 0.89
      sleep 32
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.456, room: 0.289 do
  live_loop :itsnotbass1, sync: :bar do
    if tracker[1]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/bass3.wav", amp: 1.2
      sleep 64
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.456, room: 0.289 do
  live_loop :basso2, sync: :bar do
    if tracker[2]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/bass4.wav", amp: 1.5
      sleep 64
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.156, room: 0.189 do
  live_loop :tech1, sync: :bar do
    if tracker[3]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/techno1.wav", amp: 1.2
      sleep 16
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.256, room: 0.689 do
  live_loop :ammbii2, sync: :bar do
    if tracker[4]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/spacech.wav", cutoff: rrand(100, 120)
      sleep 16
    else
      sleep 1
    end
  end
end

live_loop :kickk3344, sync: :bar do
  if tracker[5]>0 then
    sample :bd_haus, amp: 0.7
    sample :bd_klub, amp: 1.2
    sleep 1
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.256, room: 0.389 do
  live_loop :kord, sync: :bar do
    if tracker[6]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/chord1.wav", cutoff: rrand(100, 120), amp: 1.7
      sleep 32
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.156, room: 0.289 do
  live_loop :ritmmmm44, sync: :bar do
    if tracker[7]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/ritm4.wav", amp: 1.4
      sleep 8
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.156, room: 0.789 do
  live_loop :mmelody, sync: :bar do
    if tracker[8]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/melod1.wav", cutoff: rrand(100, 120), amp: 1.3
      sleep 32
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.356, room: 0.289 do
  live_loop :ritmmmm88, sync: :bar do
    if tracker[9]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/shaker.wav", amp: 1.3
      sleep 16
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.556, room: 0.589 do
  live_loop :ritmmmm77, sync: :bar do
    if tracker[10]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/tech1.wav"
      sleep 16
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.256, room: 0.189 do
  live_loop :ritmmmm99, sync: :bar do
    if tracker[11]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/tech2.wav"
      sleep 16
    else
      sleep 1
    end
  end
end

live_loop :kick66, sync: :bar do
  if tracker[12]>0 then
    sample :bd_haus, amp: 1.3
    sleep 1
  else
    sleep 1
  end
end

with_fx :reverb, mix: 0.256, room: 0.189 do
  live_loop :bass4499, sync: :bar do
    if tracker[13]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/newbass.wav", amp: 2.5
      sleep 16
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.256, room: 0.389 do
  live_loop :mmmm, sync: :bar do
    if tracker[14]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/melod2.wav", amp: 1.5, cutoff: 113
      sleep 16
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.356, room: 0.189 do
  live_loop :hhhhh, sync: :bar do
    if tracker[15]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/hhh.wav"
      sleep 8
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.356, room: 0.189 do
  live_loop :perce, sync: :bar do
    if tracker[16]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/perc.wav"
      sleep 8
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.356, room: 0.289 do
  live_loop :rrttmm, sync: :bar do
    if tracker[17]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/rtm.wav", amp: 1.7
      sleep 32
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.356, room: 0.189 do
  live_loop :hhh12, sync: :bar do
    if tracker[18]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/hhh2.wav"
      sleep 16
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.356, room: 0.189 do
  live_loop :hhh13, sync: :bar do
    if tracker[19]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/hhh1.wav"
      sleep 16
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.156, room: 0.389 do
  live_loop :tabla1, sync: :bar do
    stop
    if tracker[20]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/ffmm.wav", amp: 1.6
      sleep 32
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.156, room: 0.389 do
  live_loop :tabla2, sync: :bar do
    stop
    if tracker[21]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/hhrtm.wav", amp: 1.6
      sleep 32
    else
      sleep 1
    end
  end
end


with_fx :reverb, mix: 0.456, room: 0.489 do
  live_loop :hayhet4, sync: :bar do
    if tracker[22]>0 then
      sleep 0.5
      sample "C:/Users/Berke/Music/Glitch With Friends+/Drums/Hats and Miscellaneous Percussion/CLAUDE - hat12.wav",
        amp: 0.8, cutoff: 110
      sleep 0.5
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.256, room: 0.289 do
  live_loop :hayhet3, sync: :bar do
    if tracker[23]>0 then
      a = 0.59
      sample "C:/Users/Berke/Music/Glitch With Friends+/Drums/Hats and Miscellaneous Percussion/CLAUDE - hat12.wav",
        amp: a if pattern "-x-x-xx---xxxx"
      sleep 0.25
    else
      sleep 1
    end
  end
end

with_fx :reverb, mix: 0.156, room: 0.389 do
  live_loop :ambi61, sync: :bar do
    if tracker[24]>0 then
      sample "C:/Users/Berke/Music/AbleforSonic/ambi7.wav", amp: 2
      sleep 64
    else
      sleep 1
    end
  end
end


#SCRİPT333333333333

start_loop 0
sleep 32
start_loop 1
sleep 128
start_loop 2
stop_loop 1
sleep 64
start_loop 4
stop_loop 0
sleep 32
start_loop 3
sleep 80
stop_loop 3
start_loop 6
set_mixer_control! hpf_slide: 32, hpf: 105
sleep 32
stop_loop 2
sleep 16
set_mixer_control! hpf_slide: 1, hpf: 10
start_loop 5 #kick
sleep 16
start_loop 7
sleep 48
start_loop 9
sleep 32
stop_loop 4
start_loop 9
start_loop 8
sleep 32
stop_loop 5
set_mixer_control! hpf_slide: 16, hpf: 100
sleep 32
set_mixer_control! hpf_slide: 1, hpf: 10
start_loop 10
set_mixer_control! lpf_slide: 32, lpf: 45
sleep 16
start_loop 11
sleep 16
stop_loop 9
set_mixer_control! lpf_slide: 1, lpf: 120
start_loop 12 #new kick
start_loop 13
stop_loop 6
sleep 32
start_loop 14
sleep 64
stop_loop 12
sleep 16
start_loop 12
start_loop 15
start_loop 16
sleep 32
stop_loop 10
sleep 16
stop_loop 8
sleep 32
set_mixer_control! lpf_slide: 2, lpf: 20
stop_loop 7
stop_all
sleep 2
set_mixer_control! lpf_slide: 1, lpf: 120
start_loop 12
start_loop 13
start_loop 14
sleep 64
start_loop 17
sleep 32
start_loop 19
sleep 32
stop_loop 12
set_mixer_control! hpf_slide: 2, hpf: 110
sleep 4
set_mixer_control! hpf_slide: 1, hpf: 10
start_loop 12
sleep 32
stop_loop 19
start_loop 18
sleep 32
stop_loop 12
stop_loop 17
sleep 16
start_loop 12
##| start_loop 21
sleep 32
start_loop 22
sleep 32
start_loop 23
sleep 32
stop_loop 18
##| stop_loop 21
start_loop 19
sleep 64
stop_loop 19
start_loop 24
sleep 64
stop_loop 12
sleep 32
stop_loop 23
sleep 16
stop_loop 14
sleep 16
stop_loop 17
sleep 16
stop_loop 21
sleep 16
stop_loop 13
sleep 16
set_mixer_control! lpf_slide: 32, lpf: 0
stop_loop 22
sleep 16
stop_loop 24
stop_all



#BUFFER 4--------------------------------------------------------------


##| use_bpm 138
use_bpm 140

##| 1.times do
##|   sample "C:/Users/Berke/Music/soundRecords/alwaaysthesameshit.wav", amp: 1.5
##|   sleep 275
##| end

6.times do
  with_fx :echo, decay: 2 do
    with_fx :reverb, mix: 0.76, room: 0.68 do
      sample "C:/Users/Berke/Music/AbleforSonic/trans1.wav", amp: 1.2
      sleep 64
      
    end
  end
end



#BUFFER 5--------------------------------------------------------------



use_bpm 140

6.times do
  with_fx :reverb, mix: 0.76, room: 0.68 do
    sample "C:/Users/Berke/Music/AbleforSonic/ambi4.wav", amp: 1.5
    sleep 128
  end
end


#BUFFER 6--------------------------------------------------------------



use_bpm 142

##| 6.times do
##| sample "C:/Users/Berke/Music/AbleforSonic/ambi5.wav", amp: 1.7
##| sleep 128
##| end

16.times do
  with_fx :reverb, mix: 0.256, room: 0.789 do
    sample "C:/Users/Berke/Music/AbleforSonic/ambi6.wav", amp: 1.8
    sleep 32
  end
end
