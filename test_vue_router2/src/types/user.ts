export interface User {
  id: number;
  username: string;
  password?: string;
  name?: string;
  email?: string;
  status?: string;
  roles?: Role[];
}

export interface Role {
  id: number;
  code: string;
  name: string;
  description?: string;
  status?: string;
  permissions?: Permission[];
}

export interface Permission {
  id: number;
  code: string;
  name: string;
  type?: string;
  path?: string;
  parentId?: number;
  description?: string;
  status?: string;
}

