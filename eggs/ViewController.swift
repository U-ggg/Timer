//
//  ViewController.swift
//  eggs
//
//  Created by Sidzhe on 4/4/23.
//

import UIKit
import SnapKit
import AVFAudio


class ViewController: UIViewController {
    
    let stackViewVertical: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 36
        return stackView
    }()
    
    let stackViewHorizontal: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.text = "Do you like eggs?"
        label.font = UIFont(name: "Menlo", size: 30)
        return label
    }()
    
    let imageEggSoft: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "soft_egg")
        return image
    }()
    
    let imageEggMedium: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "medium_egg")
        return image
    }()
    
    let imageEggHard: UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "hard_egg")
        return image
    }()
    
    let buttonSoft: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("soft", for: .normal)
        button.setTitleColor(.clear, for: .normal)
        return button
    }()
    
    let buttonMedium: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("medium", for: .normal)
        button.setTitleColor(.clear, for: .normal)
        return button
    }()
    
    let buttonHard: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitle("hard", for: .normal)
        button.setTitleColor(.clear, for: .normal)
        return button
    }()
    
    let progressView: UIProgressView = {
        let progressView = UIProgressView(progressViewStyle: .bar)
        progressView.tintColor = UIColor(named: "CustomYellow")
        progressView.progress = 1.0
        return progressView
    }()
    
    let labelView = UIView()
    let eggSoftView = UIView()
    let eggMediumView = UIView()
    let eggHardView = UIView()
    let timerView = UIView()
    var totalTime = 0
    var secondsPassed = 0
    var timer = Timer()
    var player: AVAudioPlayer?

    let dictTimeToReady = ["soft" : 3, "medium" : 15, "hard" : 700]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemMint
        
        setupViews()
        setupConstraints()
        
    }
    
// MARK: --------------- Add views
    
    private func setupViews() {
        view.addSubview(stackViewVertical)
        labelView.addSubview(label)
        stackViewVertical.addArrangedSubview(labelView)
        stackViewVertical.addArrangedSubview(stackViewHorizontal)
        stackViewHorizontal.addArrangedSubview(eggSoftView)
        stackViewHorizontal.addArrangedSubview(eggMediumView)
        stackViewHorizontal.addArrangedSubview(eggHardView)
        stackViewVertical.addArrangedSubview(timerView)
        eggSoftView.addSubview(imageEggSoft)
        eggMediumView.addSubview(imageEggMedium)
        eggHardView.addSubview(imageEggHard)
        eggSoftView.addSubview(buttonSoft)
        eggMediumView.addSubview(buttonMedium)
        eggHardView.addSubview(buttonHard)
        timerView.addSubview(progressView)

        
        buttonSoft.addTarget(self, action: #selector(pressButton(_:)), for: .touchUpInside)
        buttonMedium.addTarget(self, action: #selector(pressButton(_:)), for: .touchUpInside)
        buttonHard.addTarget(self, action: #selector(pressButton(_:)), for: .touchUpInside)
    }
    
// MARK: ---------------  Setup constraints
    
    private func setupConstraints() {
        stackViewVertical.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.trailing.leading.equalToSuperview().inset(16)
        }
        
        label.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        imageEggSoft.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(130)
        }
        
        imageEggMedium.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(130)
        }
        
        imageEggHard.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(100)
            make.height.equalTo(130)
        }
        
        buttonSoft.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        buttonMedium.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        buttonHard.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.height.equalTo(100)
        }
        
        progressView.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.center.equalToSuperview()
            make.height.equalTo(7)
        }
        
    }
    
// MARK:  ---------------   Methods
    
    @objc private func pressButton(_ sender: UIButton) {
        totalTime = dictTimeToReady[sender.currentTitle!]!
        
        timer.invalidate()
        progressView.progress = 0.0
        secondsPassed = 0

        timer = Timer.scheduledTimer(timeInterval: 1.0,
                             target: self,
                             selector: #selector(checkTimer),
                             userInfo: nil,
                             repeats: true)
        
    }
    
    @objc private func checkTimer() {
        label.text = "Do you like eggs?"
        
        if secondsPassed < totalTime {
            secondsPassed += 1
            let progress = Float(secondsPassed) / Float(totalTime)
            progressView.progress = progress
            
            
        } else {
            label.text = "Ready to eat!"
            timer.invalidate()
           
            let url = Bundle.main.url(forResource: "alarm_sound", withExtension: "mp3")
            player = try? AVAudioPlayer(contentsOf: url!)
            player?.play()
        }
    }
    
}

