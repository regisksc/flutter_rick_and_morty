# flutter_rick_morty

This project aimed to practice flutter skills.

## How to run:

#### make sure you are in project root and then

```python
cd scrips

./runDev.sh # runs dev Flavor
./runQa.sh # runs qa Flavor
./runProd.sh # runs prod Flavor
```

#### This repository features extra scripts:

```python
cd scrips # if you aren't already in this folder

./runCodeMetrics.sh # generates code analysis (visualize it in /metrics/index.html)
./runFormat.sh # runs formatter to organize imports in whole project
./runTests.sh # runs all unit tests in project and generates test coverage in files (visualize it in /coverage/index.html)
./runIntegrationTests.sh # runs integration tests
```

# Contents

- Clean Architecture
- Design Patterns
- Api communication
- Simple State Management (Streams and setState)
- Unit tests
- Animations

# Observations

- Sometimes the api returns a redirect to the same url, thus making the dio client enter a loop, restarting the app usually solves this.
