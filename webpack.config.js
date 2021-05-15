const CopyPlugin = require("copy-webpack-plugin");
const config = require("@softwareventures/webpack-config");

module.exports = config({
    title: "Deep Sea Salvage",
    vendor: "dcgw",
    html: {
        template: "index.html"
    },
    customize: configuration => ({
        ...configuration,
        plugins: [
            ...configuration.plugins,
            new CopyPlugin({
                patterns: [{ from: "fonts", to: "" }]
            })
        ]
    })
});
