package main

import (
	"bytes"
	"fmt"
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

	// Sources
	jabraSource = "alsa_input.usb-0b0e_Jabra_Speak_710_70BF9200C6A0-00.mono-fallback"
	yetiSource  = "alsa_input.usb-Blue_Microphones_Yeti_Stereo_Microphone_LT_1906112229019B8B0391_111000-00.analog-stereo"

	// Sinks
	hdmiSink       = "alsa_output.pci-0000_81_00.1.hdmi-stereo"
	jabraSink      = "alsa_output.usb-0b0e_Jabra_Speak_710_70BF9200C6A0-00.analog-stereo"
	headphonesSink = "alsa_output.usb-0d8c_C-Media_USB_Audio_Device-00.analog-stereo"
	// headphonesSink = "alsa_output.usb-0d8c_C-Media_USB_Audio_Device-00.iec958-stereo"
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
	var stdout, stderr bytes.Buffer
	c := exec.Command(cmd, args...)
	c.Stdout = &stdout
	c.Stderr = &stderr
	err := c.Run()
	if err != nil {
		errMsg := fmt.Sprintf("[%s]: %v %v", c.Args, err, stderr.String())
		notifyLevel(CriticalUrgency, errMsg, 250*time.Millisecond)
		log.Fatalf("%s\n", errMsg)
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
		command("pactl", "set-default-sink", headphonesSink)
		command("pactl", "set-default-source", yetiSource)
		notify("Set Output To Headphones", 250*time.Millisecond)
	case "jabra":
		command("pactl", "set-default-sink", jabraSink)
		command("pactl", "set-default-source", jabraSource)
		notify("Set Output To Jabra", 250*time.Millisecond)
	case "hdmi":
		command("pactl", "set-default-sink", hdmiSink)
		command("pactl", "set-default-source", yetiSource)
		notify("Set Output To HDMI", 250*time.Millisecond)
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
	case "hdmi":
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
		command("pactl", "set-source-mute", yetiSource, "1")
		// command("pactl", "set-source-mute", jabraSource, "1")
		// notify("Muted", 250*time.Millisecond)
		// command("i3-msg", "bar", "mode", "dock", "mute-bar")
	case "unmute-mic":
		command("pactl", "set-source-mute", yetiSource, "0")
		// command("pactl", "set-source-mute", jabraSource, "0")
		// notify("Unmuted", 250*time.Millisecond)
		// command("i3-msg", "bar", "mode", "invisible", "mute-bar")
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
