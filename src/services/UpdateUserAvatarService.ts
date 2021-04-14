import { getRepository } from 'typeorm';
import path from 'path';
import fs from 'fs';
import uploadConfig from '../config/upload';

import AppError from '../errors/AppError';

import User from '../models/User';

interface Request {
  user_id: string;
  avatarFileName: string;
}

class UpdateUserAvatarService {
  public async execute({ user_id, avatarFileName }: Request): Promise<User> {
    const usersRepository = getRepository(User);
    const user = await usersRepository.findOne(user_id);

    if (!user) {
      throw new AppError('This user is not exists', 401);
    }

    if (user.avatar) {
      const userAvatarFilePath = path.join(uploadConfig.diretory, user.avatar);
      const userAvatarExists = await fs.promises.stat(userAvatarFilePath);

      if (userAvatarExists) {
        await fs.promises.unlink(userAvatarFilePath);
      }
    }

    user.avatar = avatarFileName;

    await usersRepository.save(user);

    return user;
  }
}

export default UpdateUserAvatarService;
