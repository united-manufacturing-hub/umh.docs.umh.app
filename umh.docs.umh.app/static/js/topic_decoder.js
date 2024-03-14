document.addEventListener('DOMContentLoaded', function() {
    const inputField = document.getElementById('inputTopic');
    const outputField = document.getElementById('outputMatches');
    function containsInvalidChars(str) {
        return /[^a-zA-Z0-9._-]/.test(str);
    }
    function containsMultipleCharacters(str, character) {
        const regex = new RegExp(`${character}{2,}`, 'g');
        return regex.test(str);
    }
    inputField.addEventListener('input', function() {
        const regex = /^umh\.v1\.(?<enterprise>[\w\-_]+)\.((?<site>[\w\-_]+)\.)?((?<area>[\w\-_]+)\.)?((?<productionLine>[\w\-_]+)\.)?((?<workCell>[\w\-_]+)\.)?((?<originId>[\w\-_]+)\.)?(?<schema>(_\w+))(\.(?<tag>[\w\-_.]+))?$/;
        // Strip whitespaces & replace / with .
        let value = inputField.value.trim();
        if (value.length === 0){
            outputField.textContent = "";
        }
        const containsBothSlashAndDot = value.includes('/') && value.includes('.');
        if (containsBothSlashAndDot){
            outputField.textContent = "❗Invalid Topic\n";
            outputField.textContent += "You are mixing Kafka & MQTT style separators."
            return;
        }
        value = value.replaceAll('/','.');
        if (containsInvalidChars(value)){
            outputField.textContent = "❗Invalid Topic\n";
            outputField.textContent += "You are using invalid characters."
            return;
        }
        // Check for multiple topic separators
        if (containsMultipleCharacters(value, "\\.")){
            outputField.textContent = "❗Invalid Topic\n";
            outputField.textContent += "You are using multiple topic separators without text between."
            return;
        }
        if (containsMultipleCharacters(value, "_")){
            outputField.textContent = "❗Invalid Topic\n";
            outputField.textContent += "You are using multiple tag group separators without text between."
            return;
        }

        const matches = regex.exec(value);
        if (matches) {
            /*
            if (matches.groups.tag) {
                // Replace dots with underscores in tag
                matches.groups.tag = matches.groups.tag.replaceAll('.', '_');
            }*/
            outputField.textContent = "✔️ Valid Topic\n";
            if (matches.groups.schema === "_historian"){
                outputField.textContent += "✅ Using UMH _historian schema\n"
            }else if (matches.groups.schema === "_analytics"){
                outputField.textContent += "✅ Using UMH _analytics schema\n"
                // Check if tag is present
                console.log(matches.groups.tag);
                if (!matches.groups.tag){
                    outputField.textContent = "❗ Tag is missing for _analytics schema\n"
                }
                // Validate tag
                // One of: work-order/create, work-order/start, work-order/stop, product-type/create, product/add, product/setBadQuantity, shift/add, shift/delete, state/add, state/overwrite
                const validTags = ["work-order.create", "work-order.start", "work-order.stop", "product-type.create", "product.add", "product.setBadQuantity", "shift.add", "shift.delete", "state.add", "state.overwrite"];
                if (!validTags.includes(matches.groups.tag)){
                    outputField.textContent += "❗ Invalid tag for _analytics schema\n"
                }else{
                    outputField.textContent += "✔️ Valid tag for _analytics schema\n"
                }
            }else if (matches.groups.schema === "_local"){
                outputField.textContent += "✅ Using UMH _local schema\n"
            }else{
                outputField.textContent += "ℹ️ Using custom schema\n"
            }
            outputField.textContent += JSON.stringify(matches.groups, null, 4);
            return;
        }
        outputField.textContent = "❗Invalid Topic\n";
        // Split the string
        const parts = value.split('.');
        if (parts.length < 4) {
            outputField.textContent += "Topic name must consists of at least `umh/v1/<enterprise>/<_schema>`"
            return;
        }
        if (parts[0] !== 'umh') {
            outputField.textContent += "First part of the topic must be `umh`";
            return;
        }
        if (parts[1] !== 'v1') {
            outputField.textContent += "Second part of the topic must be `v1`";
            return;
        }
        // Check if ends with dot
        if (value.endsWith('.')){
            outputField.textContent += "Topic cannot end with separator."
            return;
        }
        // Check if schema is in splits
        const index = parts.findIndex(part => part.startsWith('_') && part.length > 1)
        if (index === -1) {
            outputField.textContent += 'One or more groups start with an underscore.';
            return;
        }
        // Check empty group
        if (parts.some(part => part.length === 0)) {
            outputField.textContent += 'One or more groups are empty.';
            return;
        }
        // Check if _schema is to late
        if (index >= 9){
            outputField.textContent += "To many groups before the _schema, consider using tag grouping";
            return;
        }

    });
});
