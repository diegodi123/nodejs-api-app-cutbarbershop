import { Router } from 'express';
import multer from 'multer';
import uploadConfig from '../config/upload';

import CreateUserService from '../services/CreateUserService';
import UpdateUserAvatarService from '../services/UpdateUserAvatarService';

import ensureAuthenticated from '../middlewares/ensureAuthenticated';

const usersRouter = Router();
const upload = multer(uploadConfig);

usersRouter.post('/', async (request, response) => {
  const { name, email, password } = request.body;

  const createUser = new CreateUserService();
  const user = await createUser.execute({
    name,
    email,
    password,
  });

  delete user.password;

  return response.status(201).json(user);
});

usersRouter.put('/:id', async (request, response) => {
  const { id: user_id } = request.params;

  return response.status(201);
});

usersRouter.patch(
  '/avatar',
  ensureAuthenticated,
  upload.single('avatar'),
  async (request, response) => {
    const { id: user_id } = request.user;
    const { filename: avatarFileName } = request.file;

    const updateUserAvatar = new UpdateUserAvatarService();
    const user = await updateUserAvatar.execute({
      user_id,
      avatarFileName,
    });

    delete user.password;

    return response.status(201).json(user);
  },
);

export default usersRouter;
