## Run Locally (terminal mode)
For local development, you can easily run and interact with the agent using you CLI.

`$ npm run terminal`

## Run Agent
Agent exposeses endpoints through which user can interact with it. The main endpoint is `/chat`, which processes users input and determine actions it needs to take from prompts context.

Run agent: `$ npm run start`

## Agent Tool and Service System
Tools are functions that the agent can use to interact with external services or perform specific computations.

Directory Structure
src/
  ├── tools/
  │   ├── index.ts                    # Tool loader and registration
  │   ├── weather.ts                  # Weather tool implementation
  │   └── ...                         # Other tool implementations
  ├── services/
  │   └── IPFSService.ts              # Upload data to IPFS
  │   └── ImageGenerationService.ts   # Turn prompt into image
  │   └── ...                         # Other services
  └── ...

The AgentService loads all available tools during initialization.
