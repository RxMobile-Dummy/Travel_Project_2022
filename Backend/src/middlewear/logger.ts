import express, { Express, Request, Response } from 'express';

const LoggerMiddleware = (req: Request, res: Response, next: any) => {

    console.log(`Url ${req.url} ${req.method} -- ${new Date()}`);

    next();

};

export { LoggerMiddleware };