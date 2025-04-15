# MacOS-Stay-Asleep
A script to take care of your Macbook and put it back to sleep if it gets woken up via an unwanted background task while the lid is off.

To write a macOS script that checks if the machine was woken up while the lid is closed and then puts it back to sleep, we need to:

Detect if the system just woke from sleep.

Check if the lid is closed (this is tricky, as macOS doesn’t provide a simple public API to check this).

To put the machine back to sleep if the lid is closed.

Limitations:

macOS does not officially expose the lid state via the command line or script.

We can infer the lid is closed if the internal display is off and no external display is connected.

We can use system logs to detect wake events.

Here’s a script using pmset, ioreg, and system_profiler that can be run via a launchd agent or cron job (though launchd is recommended on macOS).

Make sure to set the right permission for the script to be executable using:

```
chmod +x check_wake_and_lid.sh
```
