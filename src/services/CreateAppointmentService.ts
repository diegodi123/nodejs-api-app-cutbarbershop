import { startOfHour } from 'date-fns';
import { getCustomRepository, getRepository } from 'typeorm';

import Appointment from '../models/Appointment';
import AppointmentsRepository from '../repositories/AppointmentsRepository';

import AppError from '../errors/AppError';
import User from '../models/User';

interface Request {
  date: Date;
  provider_id: string;
}

class CreateAppointmentService {
  public async execute({ provider_id, date }: Request): Promise<Appointment> {
    const appointmentsRepository = getCustomRepository(AppointmentsRepository);
    const usersRepository = getRepository(User);
    const appointmentDate = startOfHour(date);
    const providerExists = await usersRepository.findOne({
      where: { id: provider_id },
    });

    if (!providerExists) {
      throw new AppError('This user is not exists');
    }

    const findAppointmentInSameDate = await appointmentsRepository.findByDate(
      appointmentDate,
    );

    if (findAppointmentInSameDate) {
      throw new AppError('This appointment is already booked');
    }

    const appointment = appointmentsRepository.create({
      provider_id,
      date: appointmentDate,
    });

    await appointmentsRepository.save(appointment);

    return appointment;
  }
}

export default CreateAppointmentService;
