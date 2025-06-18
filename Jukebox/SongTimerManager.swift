import Foundation

class SongTimerManager {
    private var timer: Timer?
    private(set) var duration: TimeInterval = 0
    private(set) var currentTime: TimeInterval = 0

    var onTick: ((TimeInterval, TimeInterval) -> Void)?
    var onSongEnded: (() -> Void)?

    func start(from current: TimeInterval = 0, duration: TimeInterval) {
        stop()
        self.duration = duration
        self.currentTime = current

        onTick?(currentTime, duration)

        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.currentTime += 1
            self.onTick?(self.currentTime, self.duration)

            if self.currentTime >= self.duration {
                self.stop()
                self.onSongEnded?()
            }
        }
    }

    func stop() {
        timer?.invalidate()
        timer = nil
    }

    func reset() {
        stop()
        currentTime = 0
        onTick?(currentTime, duration)
    }
}
