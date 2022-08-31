# **Backend**
# Architecture:
A typical architecture of our project looks like model,controller, and domain.
so we can identify 3 main components like:
## Model: 
- This level we defined collection schema for mongose and basic schema validation is written at here.
- Model is export for further query use 
## Controller:
- This level all the controller is defined, controller called to domain level method and also router is at this level 
- Router defined url for api and which type of request is their is written
## Domain:
- In this level our main logic of the method or functionality is written 
- Here, all type mongose query and collection customiztion is in the method
# Project Struture 
```.
└── Backend
    ├── src
    │   ├── authentication
    │   ├── controller
    │   ├── domain
    │   ├── model
    │   ├── middleware
    │   ├── app.ts
    │   └── status_code.ts
    ├── package.json
    └── tsconfig.json
```
# Node module download command
    npm install
# Running the server
    npm run dev