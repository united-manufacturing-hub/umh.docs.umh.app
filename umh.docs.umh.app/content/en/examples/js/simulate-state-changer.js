const now = Date.now();
const lastChange = msg.payload.state.lastchange;
const duration = now - lastChange;
const cycleTime = 10;

msg.delay = cycleTime;

// Function to calculate dynamic delay
function calculateDynamicDelay(duration, startDelay, endDelay, rampTime) {
    if (duration >= rampTime) return endDelay;
    const delayRange = startDelay - endDelay;
    const delayStep = delayRange / rampTime;
    return startDelay - (delayStep * duration);
}

switch (msg.payload.state.id) {
    case 10000:
        // ProducingAtFullSpeedState
        // After 10 seconds it has a 10% chance of changing the state
        if (Math.random() < 0.1 && duration >= 10000) {
            if (Math.random() < 0.5) {
                // Simulate a CleaningState
                msg.payload.state.id = 110000;
                msg.payload.state.lastchange = Date.now();
            } else {
                // Simulate an OutletJamState
                msg.payload.state.id = 70000;
                msg.payload.state.lastchange = Date.now();
            }
        }
        break;
    case 20000:
        // ProducingAtLowerThanFullSpeedState
        // The machine takes 30s to ramp to full speed
        if (duration >= 30000) {
            msg.payload.state.id = 10000;
            msg.payload.state.lastchange = Date.now();
        }
        // Calculate dynamic delay starting from 500 to 100 over 30 seconds
        msg.delay = calculateDynamicDelay(duration, 500, 100, 30000);
        break;
    default:
        if (msg.payload.state.id == 110000) {
            // We have a cleaning state, this one takes 10 seconds to complete
            if (duration >= 10000) {
                // Machine needs to ramp up after cleaning
                msg.payload.state.id = 20000;
                msg.payload.state.lastchange = Date.now();
            }
        } else if (msg.payload.state.id == 70000) {
            // We have an outlet jam state, this one takes 15 seconds to complete
            if (duration >= 15000) {
                // Machine needs to ramp up after fixing the jam
                msg.payload.state.id = 20000;
                msg.payload.state.lastchange = Date.now();
            }
        }
}

if (msg.payload.state.id < 30000) {
    return [null, msg];
}

return [msg, null];