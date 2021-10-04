const request = require("supertest")
let { server } = require("../helper")
jest.mock("console");
beforeEach(() => {

})

afterAll((done) => {
    done();
})

describe("search Course cases", () => {
    it("should get courses without course param", async (done) => {
        const resp = await request(server).get("/searchCourse").query({ gpa: 6.55, greScore: 140, country: "united states", courseName: null })
        expect(resp.statusCode).toBe(200);
        done();
    })
    it("should get courses with course param", async (done) => {
        const resp = await request(server).get("/searchCourse").query({ gpa: 6.55, greScore: 140, country: "united states", courseName: "chemial" })
        expect(resp.statusCode).toBe(200);
        done();
    })
})