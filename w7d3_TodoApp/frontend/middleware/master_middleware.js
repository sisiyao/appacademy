import { applyMiddleware } from 'redux';
import { TodoMiddleware } from './todo_middleware.js';

export const MasterMiddleware = applyMiddleware(TodoMiddleware);
