import { combineReducers } from 'redux';
import EmptyStateReducer from './Components/EmptyState/EmptyStateReducer';

const reducers = {
  foremanMetal: combineReducers({
    emptyState: EmptyStateReducer,
  }),
};

export default reducers;
