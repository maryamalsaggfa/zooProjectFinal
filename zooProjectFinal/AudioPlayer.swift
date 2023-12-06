import AVFoundation


    
  


class AudioPlayer {
    static let shared = AudioPlayer()
    private var audioPlayer: AVAudioPlayer?
    
    func playMusic() {
        if let soundURL = Bundle.main.url(forResource: "MM", withExtension: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
                audioPlayer?.play()
            } catch {
                print("لا يمكن تشغيل الملف الصوتي.")
            }
        }
    }
    
    func toggleMute(isMuted: Bool) {
        if isMuted {
            audioPlayer?.volume = 0.0 // كتم الصوت
        } else {
            audioPlayer?.volume = 1.0 // إعادة تشغيل الصوت
        }
    }
}
