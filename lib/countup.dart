import 'package:flutter/material.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';
import 'package:timer/buttons.dart';

class CountUpTimerPage extends StatefulWidget {
  const CountUpTimerPage({super.key});

  @override
  TimerState createState() => TimerState();
}

class TimerState extends State<CountUpTimerPage> {
  final StopWatchTimer _stopWatchTimer = StopWatchTimer(
    mode: StopWatchMode.countUp
  );

  late final StopWatchTimer _stopWatchTimerDown;

  final _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    _stopWatchTimerDown = StopWatchTimer(
      mode: StopWatchMode.countDown,
      onEnded: () => _stopWatchTimer.onStartTimer(),
    );

    _stopWatchTimerDown.setPresetSecondTime(10);
  }

  @override
  void dispose() async {
    super.dispose();
    await _stopWatchTimer.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 16,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                StreamBuilder<int>(
                  stream: _stopWatchTimerDown.rawTime,
                  initialData: _stopWatchTimerDown.rawTime.value,
                  builder: (context, snap) {
                    final value = snap.data!;
                    final displayTime =
                    StopWatchTimer.getDisplayTime(value, hours: false, minute: false, milliSecond: false);
                    final showTimer = _stopWatchTimerDown.isRunning;
                    return showTimer ? Column(
                      children: <Widget>[
                        Text(
                          displayTime,
                          style: const TextStyle(
                              fontSize: 150,
                              fontFamily: 'Helvetica',
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ) : const SizedBox(height: 0,);
                  },
                ),

                /// Display stop watch time
                StreamBuilder<int>(
                  stream: _stopWatchTimer.rawTime,
                  initialData: _stopWatchTimer.rawTime.value,
                  builder: (context, snap) {
                    final value = snap.data!;
                    final displayTime =
                    StopWatchTimer.getDisplayTime(value, hours: false, milliSecond: false);
                    final showTimer = !_stopWatchTimerDown.isRunning;
                    return showTimer ? Column(
                      children: <Widget>[
                        Text(
                          displayTime,
                          style: const TextStyle(
                              fontSize: 150,
                              fontFamily: 'Helvetica',
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ) : const SizedBox(height: 0,);
                  },
                ),

                /// Lap time.
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: SizedBox(
                    height: 200,
                    child: StreamBuilder<List<StopWatchRecord>>(
                      stream: _stopWatchTimer.records,
                      initialData: _stopWatchTimer.records.value,
                      builder: (context, snap) {
                        final value = snap.data!;
                        if (value.isEmpty) {
                          return const SizedBox.shrink();
                        }
                        Future.delayed(const Duration(milliseconds: 100), () {
                          _scrollController.animateTo(
                              _scrollController.position.maxScrollExtent,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeOut);
                        });
                        return ListView.builder(
                          controller: _scrollController,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            final data = value[index];
                            return Column(
                              children: <Widget>[
                                Padding(
                                  padding: const EdgeInsets.all(8),
                                  child: Text(
                                    '${index + 1} ${data.displayTime}',
                                    style: const TextStyle(
                                        fontSize: 17,
                                        fontFamily: 'Helvetica',
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                const Divider(
                                  height: 1,
                                )
                              ],
                            );
                          },
                          itemCount: value.length,
                        );
                      },
                    ),
                  ),
                ),

                Padding(
                  padding: const EdgeInsets.all( 16 ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: RoundedIconButton(
                            backgroundColor: Colors.transparent,
                            onTap: () {
                              _stopWatchTimer.onResetTimer();
                              _stopWatchTimerDown.onResetTimer();
                              _stopWatchTimerDown.onStartTimer();
                            },

                            icon: const Icon(Icons.fast_forward, color:  Colors.green, size: 70,),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: RoundedIconButton(
                            backgroundColor: Colors.transparent,
                            onTap: () {
                              _stopWatchTimer.onResetTimer();
                              _stopWatchTimerDown.onResetTimer();
                              _stopWatchTimer.onStartTimer();
                            },

                            icon: const Icon(Icons.play_arrow, color: Colors.green, size: 70,),
                          ),
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: RoundedIconButton(
                            backgroundColor: Colors.transparent,
                            onTap: () {

                              if(!_stopWatchTimer.isRunning){
                                _stopWatchTimer.onResetTimer();
                              }

                              _stopWatchTimer.onStopTimer();
                              _stopWatchTimerDown.onStopTimer();
                            },

                            icon: const Icon(Icons.square, color: Colors.green, size: 70,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12,),
                /// Button
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[

                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: RoundedButton(
                          color: Colors.red,
                          onTap: () {
                            _stopWatchTimer.onResetTimer();
                            _stopWatchTimerDown.onResetTimer();
                          },
                          label: const Text(
                            'Reset',
                            style: TextStyle(color: Colors.white,fontSize: 20),
                          ),
                          icon: const Icon(Icons.refresh, color: Colors.white,),
                        ),
                      ),
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        child: RoundedButton(
                          color: Colors.deepPurpleAccent,
                          onTap: _stopWatchTimer.onAddLap,
                          label: const Text(
                            'Lap',
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                          icon: const Icon(Icons.restart_alt, color: Colors.white,),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}