{-|
Extensions to Session.
Can be used imported in the same namespace as @Hasql.Session@ without conflicts.
-}
module Hasql.Transaction.Session
where

import Hasql.Transaction.Prelude
import Hasql.Transaction.Requisites.Model
import Hasql.Transaction.Requisites.Sessions
import Hasql.Session
import qualified Hasql.Transaction.Transaction as Transaction
import qualified Hasql.Transaction.Transaction as Reexports (Transaction)


{-|
Execute an alternating transaction arrow providing an input for it.
-}
transact :: Transaction.Transaction i o -> i -> Session o
transact (Transaction.Transaction mode level list) i =
  inAlternatingTransaction mode level (fmap (\ fn -> runStateT (fn i) Uncondemned) list)
