//
//  PlayerViewCellViewController.swift
//  JustMusic-Demo
//
//  Created by админ on 24.01.2023.
//
import AVFoundation
import UIKit

class PlayerViewController: UIViewController {
    
    public var position: Int = 0
    public var songs: [Song] = []

    
    @IBOutlet var holder: UIView!
    
    var player = AVAudioPlayer()
    
    //interface elements
    private let albumImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let artistNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let albumNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private let songNameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    // control's button
    let playButton = UIButton()

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        if holder.subviews.count == 0 {
            configure()
        }
    }
    
    func configure() {
        //player
        let song = songs[position]
        let urlString = Bundle.main.url(forResource: song.trackName, withExtension: "mp3")
        
        do {
            try AVAudioSession.sharedInstance().setMode(.default)
            try AVAudioSession.sharedInstance().setActive(true, options: .notifyOthersOnDeactivation)
            
            guard let urlString = urlString else {
                return
            }
            
            player = try AVAudioPlayer(contentsOf: urlString)
            
            player.volume = 0.5
            player.play()
            
        } catch {
            print("error")
        }
        //user interface
        
        //album cover
        albumImageView.frame = CGRect(x: 10,
                                      y: 10,
                                      width: holder.frame.size.width-20,
                                      height: holder.frame.size.width-20)
        albumImageView.image = UIImage(named: song.cover)
        holder.addSubview(albumImageView)
        
        //song name, album name, artist name adding
        
        songNameLabel.frame = CGRect(x: 10,
                                     y: albumImageView.frame.size.height + 10,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        albumNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 70,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        artistNameLabel.frame = CGRect(x: 10,
                                      y: albumImageView.frame.size.height + 10 + 140,
                                      width: holder.frame.size.width-20,
                                      height: 70)
        
        songNameLabel.text = song.title
        albumNameLabel.text = song.album
        artistNameLabel.text = song.artist
        
        holder.addSubview(songNameLabel)
        holder.addSubview(albumNameLabel)
        holder.addSubview(artistNameLabel)
        
        //slider
        let slider = UISlider(frame: CGRect(x: 20,
                                            y: holder.frame.size.height-60,
                                            width: holder.frame.size.width-40,
                                            height: 50))
        
        slider.value = 0.5
        slider.addTarget(self, action: #selector(didSlide(_ :)), for: .valueChanged)
        holder.addSubview(slider)
        
        //player contols
       
        let nextButton = UIButton()
        let backButton = UIButton()
        
        //frame set
        let ySide = artistNameLabel.frame.origin.y + 70 + 20
        let size: CGFloat = 60
        
        playButton.frame = CGRect(x: (holder.frame.size.width - size) / 2.0,
                                  y: ySide,
                                  width: size,
                                  height: size)
        
        nextButton.frame = CGRect(x: holder.frame.size.width - size - 20,
                                  y: ySide,
                                  width: size,
                                  height: size)
        
        backButton.frame = CGRect(x: 20,
                                  y: ySide,
                                  width: size,
                                  height: size)
        
    
        //add target
        playButton.addTarget(self, action: #selector(didTapPlayButton), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(didTapNextButton), for: .touchUpInside)
        backButton.addTarget(self, action: #selector(didTapBackButton), for: .touchUpInside)
        
        //images
        playButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
        backButton.setBackgroundImage(UIImage(systemName: "backward.fill"), for: .normal)
        nextButton.setBackgroundImage(UIImage(systemName: "forward.fill"), for: .normal)
        
        playButton.tintColor = .black
        backButton.tintColor = .black
        nextButton.tintColor = .black
        
        holder.addSubview(playButton)
        holder.addSubview(nextButton)
        holder.addSubview(backButton)
    }
    
    // buttons actions
    @objc func didTapPlayButton() {
        if player.isPlaying {
            player.pause()
            
            //show play button
            playButton.setBackgroundImage(UIImage(systemName: "play.fill"), for: .normal)
            
            //set the cover a tittle smaller
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 30,
                                              y: 30,
                                              width: self.holder.frame.size.width-60,
                                              height: self.holder.frame.size.width-60)
            })
           
        } else {
            player.play()
            
            //show pause button
            playButton.setBackgroundImage(UIImage(systemName: "pause.fill"), for: .normal)
            
            //set the cover a little bigger
            UIView.animate(withDuration: 0.2, animations: {
                self.albumImageView.frame = CGRect(x: 10,
                                              y: 10,
                                              width: self.holder.frame.size.width-20,
                                              height: self.holder.frame.size.width-20)
            })
            
        }
    }
    
    @objc func didTapNextButton() {
        if position < songs.count - 1 {
            position = position + 1
            player.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    
    @objc func didTapBackButton() {
        if position > 0 {
            position = position - 1
            player.stop()
            for subview in holder.subviews {
                subview.removeFromSuperview()
            }
            configure()
        }
    }
    //slider action
    
    @objc func didSlide(_ slider: UISlider) {
        let value = slider.value
        player.volume = value
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
            player.stop()
    }
    
}
