### 一,提取音频 从视频中
>-ar 音频采样率 
-ac 频道数

>ffmpeg -i Sample.avi -vn -ar 44100 -ac 2 -ab 192k -f mp3 Sample.mp3     
ffmpeg -i AomawaShields_2015U.mp4 -f wav -vn output1.wav     
ffmpeg -i v9uXnTn2.flv -ac 1 -ar 16000 -f wav -vn v9uXnTn2.wav暂时先用这个     
ffmpeg -i 430.flv -ac 1 -ar 8000 -f wav -vn 431.wav     

>提取效率分析    
大概是10-15s/G的提取速度    
1.6G->85M音频 91min     
55M->5M音频 5min    
200M->66M  72min     
视频质量越高提取率越低 大概5%-30%左右 但是生成音频大小约为 50M/h     
	

### 二,合成字幕 1-2min/h

>字幕文件类型转换 ffmpeg -i keyushen.srt keyushen.ass    
设置视频编码格式 ffmpeg -i wuzhenyan.flv -c:a copy -c:v h264 -vf subtitles=keyushen.srt wuzhenyan3.flv 暂时先用这个    
嵌入外挂字幕 ffmpeg -i AomawaShields_2015U.mp4 -i ted80001.srt -c:s mov_text -c:v copy -c:a copy AomawaShields_2015U2.mp4    	
合成带字幕视频ffmpeg -i 430.flv -vf subtitles=431.srt 442.flv    
	
### 三,剪辑视频

>ffmpeg  -i v9uXnTn2.flv -vcodec copy -acodec copy -ss 00:00:00 -to 00:04:30 430.flv -y
