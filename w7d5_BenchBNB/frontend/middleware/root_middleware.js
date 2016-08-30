import { applyMiddleware } from 'redux';
import BenchesMiddleware from './benches_middleware';
import SessionMiddleware from './session_middleware';

const RootMiddleware = applyMiddleware(
  BenchesMiddleware,
  SessionMiddleware
);

export default RootMiddleware;
