//
//  TuitionView.swift
//  SujataTuition
//
//  Created by Sujata Abraham on 02/03/24.
//

import Foundation
import SwiftUI
import AVKit
import AVFoundation
import CoreData

struct TuitionView: View {
    //@EnvironmentObject var dataModel: DataModel12
    let studentController: StudentController
    let sessionController: SessionController
    let pwdController: PwdController
    let studid: UUID
    let password: String
    
    var filteredstudents: [Students]{
        studentController.getAllStudents().filter{
            students in
            (students.studentid == studid)
        }
    }
    var filteredSessions: [Sessions]{
        sessionController.getAllSessions().filter{
            sessions in
            (sessions.studentid == studid)
        }
    }
    
    //var video = Bundle.main.path(forResource: "Maths6Chapter1", ofType: "m4v")
    //@State var testPlayer = AVPlayer(url: Bundle.main.url(forResource: "Maths6Chapter1", withExtension: "m4v")!)
    var body: some View{
        List{
            ForEach(filteredSessions, id:\.self) { session in
                var nameVideo = "\(String(describing: session.subject))+\(String(describing: session.grade))+\("Chapter")+\(session.sessionno)"
                //Session(session: session, player: player)
                //}
                //}
                ZStack{
                    showVideo(nameVideo: nameVideo)
                    /*.onAppear{
                     let videoURL = Bundle.main.path(forResource: "Maths6Chapter1", ofType: "m4v")!
                     let self.testPlayer = try! AVPAudioPlayer(contentsOf: URL(fileURLWithPath: videoURL))
                     }*/
                }
            }
        }
    }
}

struct showVideo: View{
    var nameVideo: String
    @State var isPlaying: Bool = false
    @State var testPlayer: AVPlayer!
    var body: some View{
        VStack{
            VideoPlayer(player: testPlayer)
                .frame(width: 320, height: 180, alignment: .center)
            //Text("Play").font(.system(size: 45))
            //    .font(.largeTitle)
            HStack{
                Spacer()
                Button{
                    
                    let videoURL = Bundle.main.path(forResource: nameVideo, ofType: "m4v")
                    self.testPlayer = AVPlayer(url: URL(fileURLWithPath: videoURL!))
                    isPlaying ? testPlayer.pause() : testPlayer.play()
                    isPlaying.toggle()
                    testPlayer.seek(to: .zero)
                } label: {
                    Image(systemName: isPlaying ? "stop" : "play")
                        .padding()
                }
                //var testPlayerlayer = AVPlayerLayer(player: testPlayer)
                //testPlayerlayer.frame = self.view?.bounds
                //testPlayerlayer.videoGravity.bounds = AVVideoScalingModeResizeAspectFill
                //self.view.layer.addSublayer(testPlayerlayer)
                
                //let testPlayer = AVPlayer(url: videoURL)
                //                                //if let videoURL{
                //VideoPlayer(player: testPlayer)
                //  .frame(width: 320, height: 180, alignment: .center)
                /*} else {
                 Text("failed to get video")
                 }*/
                /*    testPlayer.play()
                 }){
                 Image(systemName: "play.circle.fill")
                 .resizable()
                 .frame(width: 50, height: 50)
                 .aspectRatio(contentMode: .fit)
                 }
                 Button(action: {
                 testPlayer.pause()
                 }){
                 Image(systemName: "pause.circle.fill")
                 .resizable()
                 .frame(width: 50, height: 50)
                 .aspectRatio(contentMode: .fit)
                 }*/
                Spacer()
            }
        }
    }

}

/*.onAppear{
                    let video = Bundle.main.path(forResource: "Maths6Chapter1" /*"song+\(String(describing: session.subject))+\(session.sessionno)", ofType: "m4v")
                    let player = AVPlayer(url: URL(fileURLWithPath: video!))
                }*/
            }
        
    }
}*/

/*struct TuitionView_Previews: PreviewProvider {
    static var previews: some View {
        TuitionView()
    }
}*/
/*struct ListSession: View{
    @ObservedObject var session: Sessions
    var player: AVPlayer!
    
    var body: some View{
        ZStack{
            VStack{
                Text("Play").font(.system(size: 45))
                    .font(.largeTitle)
                HStack{
                    Spacer()
                    Button(action: {
                        player.play()
                    }){
                        Image(systemName: "play.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                    }
                    Button(action: {
                        player.pause()
                    }){
                        Image(systemName: "pause.circle.fill")
                            .resizable()
                            .frame(width: 50, height: 50)
                            .aspectRatio(contentMode: .fit)
                    }
                    Spacer()
                }
            }
        }
        .onAppear{
            let sample = String(session.subject + session.grade + "Chapter" + session.sessionno)
            let video = Bundle.main.path(forResource: sample /*"song+\(String(describing: session.subject))+\(session.sessionno)"*/, ofType: "mv4")
            let player = AVPlayer(url: URL(fileURLWithPath: video!))
        }
    }
}*/
