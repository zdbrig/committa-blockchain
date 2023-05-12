const Commita = artifacts.require("Commita");

contract("Commita", (accounts) => {
  let commita = null;
  before(async () => {
    commita = await Commita.deployed();
  });

  // Test the constructor and initial values
  it("Initial total positions should be 1", async () => {
    const totalPositions = await commita.totalPositions();
    assert(totalPositions.toNumber() === 1);
  });

  // Test addPosition function
  it("Should add position correctly", async () => {
    await commita.addPosition(accounts[1], { from: accounts[0] });
    const positionOwner = await commita.getOwner(1);
    assert(positionOwner === accounts[1]);
  });

  // Test getAncestors function
  it("Should get ancestors correctly", async () => {
    const ancestors = await commita.getAncestors(1);
    assert(ancestors.length === 0); // No ancestors for the first position
  });

  // Test getDescendants function
  it("Should get descendants correctly", async () => {
    await commita.addPosition(accounts[2], { from: accounts[0] });
    const descendants = await commita.getDescendants(1);
    assert(descendants.length === 1 && descendants[0].toNumber() === 2);
  });

  // Test removePosition function
  it("Should remove position correctly", async () => {
    await commita.removePosition(1, { from: accounts[1] });
    const positionOwner = await commita.getOwner(1);
    assert(positionOwner === '0x0000000000000000000000000000000000000000');
  });
});
