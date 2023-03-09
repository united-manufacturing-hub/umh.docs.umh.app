+++
title =  "Debugging using fgtrace"
description = "Tutorial on how to get started with fgtrace"
minimum_version = "0.9.10"
+++

1. Enable fgtrace

   ![ActivateFgtrace](/images/development/fgtrace/01_activate_fgtrace.png)

2. Forward the new fgtrace port

   ![ForwardFgtrace](/images/development/fgtrace/02_activate_forwarding.png)

3. Visit the `/debug/fgtrace` trace path using [Insomnia](https://insomnia.rest/) or a similar tool. Please note that it will take about half a minute for a trace to complete.

   ![InsomniaExampleTrace](/images/development/fgtrace/03_insomnia_example_trace.png)

4. Export the returned JSON

   ![InsomniaSaveJson](/images/development/fgtrace/04_insomnia_save_trace.png)

5. Open the [Perfetto UI](https://ui.perfetto.dev/)
6. Click on “Open trace file” and select the exported JSON

   ![PerfettoOpenSavedTrace](/images/development/fgtrace/05_perfetto_open_trace.png)

7. Wait for it to load
8. You are now viewing a Chrome-like waterfall graph that shows the wallclock time used by each goroutine.

   ![PerfettoTraceOverview](/images/development/fgtrace/06_perfetto_trace_overview.png)

9. Expanding a goroutine will allow you to view the function calls it made.

   ![PerfettoTraceDetails](/images/development/fgtrace/07_perfetto_trace_details.png)

10. Please note that due to our sampling frequency, function calls that take less than 0.01 seconds will not be captured.


## Changing the trace length and frequency

To control the trace length and frequency, you can use the query parameters "seconds" and "hz".

![InsomniaTraceOptions](/images/development/fgtrace/08_insomnia_trace_options.png)