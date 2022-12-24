//
//  ViewController.swift
//  MusicPlayer
//
//  Created by 김윤수 on 2022/05/03.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, AVAudioPlayerDelegate {
    
    // MARK: - Properties
    var player: AVAudioPlayer!
    var timer: Timer!
    
    // MARK: - Interface Build Outlet
    @IBOutlet var playPauseButton: UIButton!
    @IBOutlet var volumeUpButton: UIButton!
    @IBOutlet var volumeDownButton: UIButton!
    @IBOutlet var timeLabel: UILabel!
    @IBOutlet var volumeLabel: UILabel!
    @IBOutlet var progressSlider: UISlider!

    // MARK: - Method
    // MARK: Custom Method
    func initializePlayer(){
        guard let soundAsset: NSDataAsset = NSDataAsset(name: "sound") else{
            print("음원 파일 에셋을 가져올 수 없습니다.")
            return
        }
        
        do {
            try self.player = AVAudioPlayer(data: soundAsset.data)
            self.player.delegate = self
        } catch let error as NSError {
            print("플레이어 초기화 실패")
            print("코드 : \(error.code), 메세지 : \(error.localizedDescription)")
        }
        
        self.progressSlider.maximumValue = Float(self.player.duration)
        self.progressSlider.minimumValue = 0
        self.progressSlider.value = Float(self.player.currentTime)
        self.volumeLabel.text = String(self.player.volume)
        
    }
    
    func updateTimeLabelText(time: TimeInterval){
        let minuate: Int = Int(time/60)
        let second: Int = Int(time.truncatingRemainder(dividingBy: 60))
        let milisceond: Int = Int(time.truncatingRemainder(dividingBy: 1) * 100)
        
        let timeText: String = String(format: "%02ld:%02ld:%02ld", minuate, second, milisceond)
        
        self.timeLabel.text = timeText
    }
    
    func makeAndFireTimer(){
        
        self.timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true, block: { [unowned self] (timer: Timer) in
            
            if self.progressSlider.isTracking{ return }
            
            self.updateTimeLabelText(time: self.player.currentTime)
            self.progressSlider.value = Float(self.player.currentTime)
            
        })
        self.timer.fire()
    }
    
    func updateVolumeLabel(volume: Float){
        if volume > 0{
            self.volumeLabel.text = String(format:"%0.1lf",volume)
        } else{
            self.volumeLabel.text = "0"
        }
        
    }
    
    func invalidateTimer(){
        self.timer.invalidate()
        self.timer = nil
    }
    
    func addViewWithCode(){
        self.addPlayPauseButton()
        self.addTimeLabel()
        self.addProgressSlider()
        self.addVolumeLabel()
        self.addVolumeUpButton()
        self.addVolumeDownButton()
    }
    
    func addPlayPauseButton(){
        let button: UIButton = UIButton(type: UIButton.ButtonType.custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
        
        button.setImage(UIImage(systemName: "play.circle"), for: UIControl.State.normal)
        button.setImage(UIImage(systemName: "pause.circle"), for: UIControl.State.selected)
        
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 200, weight: UIImage.SymbolWeight.thin), forImageIn: UIControl.State.normal)
        button.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 200, weight: UIImage.SymbolWeight.thin), forImageIn: UIControl.State.selected)
        
        button.tintColor = UIColor.label
        
        button.addTarget(self, action: #selector(self.touchUpPlayPauseButton(_:)), for: UIControl.Event.touchUpInside)
        
        let centerX: NSLayoutConstraint
        centerX = button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = button.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 50)
        
        let width: NSLayoutConstraint
        width = button.widthAnchor.constraint(equalToConstant: 200)
        
        let height: NSLayoutConstraint
        height = button.heightAnchor.constraint(equalToConstant: 200)
        
        centerX.isActive = true
        top.isActive = true
        width.isActive = true
        height.isActive = true
        
        self.playPauseButton = button
    }
    
    func addTimeLabel(){
        let timeLabel: UILabel = UILabel()
        timeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(timeLabel)
        
        timeLabel.textColor = UIColor.label
        timeLabel.textAlignment = NSTextAlignment.center
        timeLabel.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        
        let centerX: NSLayoutConstraint
        centerX = timeLabel.centerXAnchor.constraint(equalTo: self.playPauseButton.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = timeLabel.topAnchor.constraint(equalTo: self.playPauseButton.bottomAnchor, constant: 20)
        
        centerX.isActive = true
        top.isActive = true
        
        self.timeLabel = timeLabel
        self.updateTimeLabelText(time: 0)
    }
    
    func addProgressSlider(){
        let slider: UISlider = UISlider()
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(slider)
        
        slider.minimumTrackTintColor = UIColor.red
        
        slider.addTarget(self, action: #selector(self.sliderValueChanged(_:)), for: UIControl.Event.valueChanged)
        
        let safeAreaGuide: UILayoutGuide = self.view.safeAreaLayoutGuide
        
        let centerX: NSLayoutConstraint
        centerX = slider.centerXAnchor.constraint(equalTo: self.timeLabel.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = slider.topAnchor.constraint(equalTo: self.timeLabel.bottomAnchor, constant: 16)
        
        let leading: NSLayoutConstraint
        leading = slider.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor, constant: 16)
        
        let trailing: NSLayoutConstraint
        trailing = slider.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -16)
        
        centerX.isActive = true
        top.isActive = true
        leading.isActive = true
        trailing.isActive = true
        
        self.progressSlider = slider
    }
    
    func addVolumeLabel() {
        let label: UILabel = UILabel()
        
        self.view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
        label.textAlignment = NSTextAlignment.center
        label.textColor = UIColor.label
        label.text = "0"

        
        let centerX: NSLayoutConstraint
        centerX = label.centerXAnchor.constraint(equalTo: self.progressSlider.centerXAnchor)
        
        let top: NSLayoutConstraint
        top = label.topAnchor.constraint(equalTo: self.progressSlider.bottomAnchor, constant: 20)
        
        centerX.isActive = true
        top.isActive = true
        
        self.volumeLabel = label
        
    }
    
    func addVolumeUpButton(){
        
        let upButton: UIButton
        upButton = UIButton.init(type: UIButton.ButtonType.custom)
        
        self.view.addSubview(upButton)
        
        upButton.translatesAutoresizingMaskIntoConstraints = false
        
        upButton.setImage(UIImage(systemName: "plus.circle"), for: UIControl.State.normal)
        upButton.addTarget(self, action: #selector(touchVolumeUpButton(_:)), for: UIControl.Event.touchDown)
        upButton.tintColor = UIColor.label
        upButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 35, weight: UIImage.SymbolWeight.regular), forImageIn: UIControl.State.normal)
        
        
        let centerY: NSLayoutConstraint
        centerY = upButton.centerYAnchor.constraint(equalTo: self.volumeLabel.centerYAnchor)
        
        let traling: NSLayoutConstraint
        traling = upButton.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -70)
        
        let width: NSLayoutConstraint
        width = upButton.widthAnchor.constraint(equalToConstant: 35)
        
        let height: NSLayoutConstraint
        height = upButton.heightAnchor.constraint(equalToConstant: 35)
        
        centerY.isActive = true
        traling.isActive = true
        width.isActive = true
        height.isActive = true
        
        self.volumeUpButton = upButton
        
    }
    
    func addVolumeDownButton(){
        let downButton: UIButton = UIButton(type: UIButton.ButtonType.custom)
        downButton.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(downButton)
        
        downButton.setImage(UIImage(systemName: "minus.circle"), for: UIControl.State.normal)
        downButton.tintColor = UIColor.label
        downButton.addTarget(self, action: #selector(self.touchVolumeDownButton(_:)), for: UIControl.Event.touchDown)
        downButton.setPreferredSymbolConfiguration(UIImage.SymbolConfiguration(pointSize: 35, weight: UIImage.SymbolWeight.regular), forImageIn: UIControl.State.normal)
        
        let centerY: NSLayoutConstraint = downButton.centerYAnchor.constraint(equalTo: self.volumeLabel.centerYAnchor)
        let leading: NSLayoutConstraint = downButton.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 70)
        
        centerY.isActive = true
        leading.isActive = true
        
        self.volumeDownButton = downButton
        
    }
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.addViewWithCode()
        self.initializePlayer()
        print("서브트리 테스트")
        // Do any additional setup after loading the view.
    }
    
    // MARK: IB Action
    @IBAction func touchUpPlayPauseButton(_ sender: UIButton){
        sender.isSelected = !sender.isSelected
        
        if sender.isSelected {
            self.player?.play()
        }else {
            self.player?.pause()
        }
        
        if sender.isSelected {
            self.makeAndFireTimer()
        } else {
            self.invalidateTimer()
        }
    }
    
    @IBAction func touchVolumeUpButton(_ sender: UIButton){
        self.player.volume += Float(0.1)
        self.updateVolumeLabel(volume: self.player.volume)
    }
    
    @IBAction func touchVolumeDownButton(_ sender: UIButton){
        if self.player.volume <= 0{ return }
        self.player.volume -= Float(0.1)
        self.updateVolumeLabel(volume: self.player.volume)
    }
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        self.updateTimeLabelText(time: TimeInterval(sender.value))
        if sender.isTracking { return }
        self.player.currentTime = TimeInterval(sender.value)
    }
    
    // MARK: AVAudioPlayer delegate
    func audioPlayerDecodeErrorDidOccur(_ player: AVAudioPlayer, error: Error?) {
        guard let error: Error = error else {
            print("오디오 플레이어 디코드 오류 발생")
            return
        }
        
        let message: String
        message = "오디오 플레이어 오류 발생 \(error.localizedDescription)"
        
        let alert: UIAlertController = UIAlertController(title: "알림", message: message, preferredStyle: UIAlertController.Style.alert)
        
        let okAction: UIAlertAction = UIAlertAction(title: "확인", style: UIAlertAction.Style.default) {
            (action: UIAlertAction) -> Void in
            
            self.dismiss(animated: true, completion: nil)
        }
        alert.addAction(okAction)
        self.present(alert, animated: true, completion: nil)
    }
    
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        self.playPauseButton.isSelected = false
        self.progressSlider.value = 0
        self.updateTimeLabelText(time: 0)
        self.invalidateTimer()
    }

}


