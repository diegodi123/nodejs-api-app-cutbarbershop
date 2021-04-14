import 'reflect-metadata'; // chamada do banco

import express, { Request, Response, NextFunction } from 'express';
import cors from 'cors';
// para poder pegar os erros em rotas asyncs pois o express não possui essa feature
import 'express-async-errors';

import routes from './routes';
import AppError from './errors/AppError';
import uploadConfig from './config/upload';

import './database';

const app = express();
app.use(cors());
app.use(express.json());
app.use('/files', express.static(uploadConfig.diretory));
app.use(routes);
app.use((err: Error, request: Request, response: Response, _: NextFunction) => {
  if (err instanceof AppError) {
    return response.status(err.statusCode).json({
      status: 'error',
      message: err.message,
    });
  }

  console.error(err);

  return response.status(500).json({
    status: 'error',
    message: 'Server internal error',
  });
});

app.listen(3333, () => {
  console.log('🚀 Server started on port 3333');
});
