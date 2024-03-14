// An insecure implementation of uuid4
// It's fine for this example but shouldn't be used in production
// See https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math/random for more details
function uuid4() {
    return 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx'.replace(/[xy]/g, function (c) {
        var r = Math.random() * 16 | 0, v = c == 'x' ? r : (r & 0x3 | 0x8);
        return v.toString(16);
    });
}

msg.payload = {
    "externalProductTypeId": "otto-poster",
    "productId": uuid4(),
    "endTime": Date.now(),
    "quantity": 1
};
msg.topic = "umh/v1/printingCo/lisbon/hall-a/speedmaster106/_analytics/product/add";

// 5% chance of a bad product
const failureChance = 0.05;

if (Math.random() < failureChance){
    return [msg, msg];
}

return [msg, null];