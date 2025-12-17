export interface Result<T> {
  code: number;
  message: string;
  data: T;
}

export interface LoginResponse {
  user: User;
  permissions: string[];
  roles: string[];
}

import type { User } from './user';

