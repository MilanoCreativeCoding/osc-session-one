/////////////		MILANO LIVE CODING
/////////////		Session 5 apr 2016

/////////////		Author:		Filippo Guida
/////////////		License:	Artistic License 2.0

//	DESCRIPTION:	Audio Analysis and OSC Network Communication


//Set-Up Lib:	http://doc.sccode.org/Overviews/JITLib.html
s	=	Server.default;						//SC server
p	=	ProxySpace.push(s);					//JIT Library
e	=	();									//Environment

// Audio Generation and Analysis
e[\analBus] 	= 	Bus.control(s, 1);				//Control Bus To Send Audio Datas

~audioModule 	=
{
	var signal		=	SinOsc.ar(2);
	Out.ar(0, out);

	var fft			=	FFT(LocalBuf(2048), out); 	//Fast Fourier Transform
	var loudness	=	Loudness.kr(fft);         	//Amplitude Value in Sons
	Out.kr(e[\bus1], loudness);

}.play;

// Network: UDP Communication & OSC Communication Set-up
NetAddr.broadcastFlag		=	true;

e[\osc]		= NetAddr.new(“255.255.255.255”, 32000); 			//SET OSC PORT
e[\loopOsc]	=
Routine
{
	loop{
		e[\bus1].get(
		{
				 arg value;
				 e[\osc].sendMsg("/AudioDataFilippo", value)  	//SET OSC PATH
		});

		(1/30).wait;											//SET FPS
	}
}.play;
