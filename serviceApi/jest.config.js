module.exports = {
    displayName: "My assessment",
    rootDir: "./",
    bail: true,
    testPathIgnorePatterns: ["node_modules"],
    testEnvironment: "node",
    collectCoverage: false,
    coverageReporters: ["json", "Icov", "text", "cobertura"],
    setupFilesAfterEnv: ["./jest.setup.js"],
    testRegex: "((\\.|/*.)(test))\\.js?$"
}