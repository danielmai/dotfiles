package main

import (
	"log"
	"os"
	"os/exec"
	"strconv"
	"time"
)

type NotifyUrgency string

const (
	LowUrgency      NotifyUrgency = "low"
	NormalUrgency   NotifyUrgency = "normal"
	CriticalUrgency NotifyUrgency = "critical"
)

func (n NotifyUrgency) String() string {
	urgencies := [...]string{"low", "normal", "critical"}
	x := string(n)
	for _, v := range urgencies {
		if v == x {
			return x
		}
	}
	return ""
}

func command(cmd string, args ...string) {
	err := exec.Command(cmd, args...).Run()
	if err != nil {
		notifyLevel(CriticalUrgency, "Command failed", 250*time.Millisecond)
		log.Fatalf("%v", err)
	}
}

func notify(msg string, dur time.Duration) {
	command("notify-send", "-u", "low", "-t", strconv.FormatInt(dur.Milliseconds(), 10), msg)
}

func notifyLevel(level NotifyUrgency, msg string, dur time.Duration) {
	command("notify-send", "-u", level.String(), "-t", strconv.FormatInt(dur.Milliseconds(), 10), msg)
}

func switchDevice(s string) {
	switch s {
	case "headphones":
		command("pactl", "set-default-sink", "alsa_output.usb-0d8c_C-Media_USB_Audio_Device-00.analog-stereo")
		command("pactl", "set-default-source", "alsa_input.usb-Blue_Microphones_Yeti_Stereo_Microphone_LT_1906112229019B8B0391_111000-00.analog-stereo")
		notify("Set Output To Headphones", 250*time.Millisecond)
	case "jabra":
		command("pactl", "set-default-sink", "alsa_output.usb-0b0e_Jabra_Speak_710_70BF9200C6A0-00.iec958-stereo")
		command("pactl", "set-default-source", "alsa_input.usb-0b0e_Jabra_Speak_710_70BF9200C6A0-00.multichannel-input")
		notify("Set Output To Jabra", 250*time.Millisecond)
	default:
		log.Fatalf("Unknown device: %v", s)
	}
}

func isDevice(s string) bool {
	switch s {
	case "headphones":
		return true
	case "jabra":
		return true
	default:
		return false
	}
}

func isMuteCommand(s string) bool {
	switch s {
	case "mute-mic":
		return true
	case "unmute-mic":
		return true
	default:
		return false
	}
}

func toggleMute(s string) {
	switch s {
	case "mute-mic":
		command("pactl", "set-source-mute", "alsa_input.usb-Blue_Microphones_Yeti_Stereo_Microphone_LT_1906112229019B8B0391_111000-00.analog-stereo", "1")
		command("pactl", "set-source-mute", "alsa_input.usb-0b0e_Jabra_Speak_710_70BF9200C6A0-00.multichannel-input", "1")
		notify("Muted", 250*time.Millisecond)
	case "unmute-mic":
		command("pactl", "set-source-mute", "alsa_input.usb-Blue_Microphones_Yeti_Stereo_Microphone_LT_1906112229019B8B0391_111000-00.analog-stereo", "0")
		command("pactl", "set-source-mute", "alsa_input.usb-0b0e_Jabra_Speak_710_70BF9200C6A0-00.multichannel-input", "0")
		notify("Unmuted", 250*time.Millisecond)
	default:
		log.Fatalf("Unknown command: %v", s)
	}
}

func main() {
	if len(os.Args) < 2 {
		log.Fatalf("Argument required: [headphones, jabra]")
	}
	if isDevice(os.Args[1]) {
		switchDevice(os.Args[1])
	} else if isMuteCommand(os.Args[1]) {
		toggleMute(os.Args[1])
	}
}
