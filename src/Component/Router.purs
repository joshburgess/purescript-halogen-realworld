module Component.Router where

import Prelude

import AppM (Env)
import Capability.Authenticate (class Authenticate)
<<<<<<< HEAD
import Capability.LogMessages (class LogMessages)
import Capability.ManageResource (class ManageAuthResource, class ManageResource)
=======
import Capability.LogMessages (class LogMessages, logDebug)
import Capability.ManageResource (class ManageAuthResource, class ManageResource, getTags)
>>>>>>> master
import Capability.Navigate (class Navigate)
import Capability.Now (class Now)
import Component.Page.Home as Home
import Component.Page.Settings as Settings
import Control.Monad.Reader (class MonadAsk)
import Data.Either.Nested (Either2)
import Data.Functor.Coproduct.Nested (Coproduct2)
import Data.Maybe (Maybe(..))
import Data.Route (Route(..))
import Effect.Aff.Class (class MonadAff)
import Halogen as H
import Halogen.Component.ChildPath as CP
import Halogen.HTML as HH
import Halogen.HTML.Events as HE

type State =
  { route :: Route 
  }

data Query a
  = Navigate Route a
  | Click a

type ChildQuery = Coproduct2
  Home.Query
  Settings.Query

type ChildSlot = Either2
  Unit
  Unit

component
  :: forall m
   . MonadAff m
  => MonadAsk Env m
  => Now m
  => LogMessages m
  => Authenticate m
  => Navigate m
  => ManageResource m
  => ManageAuthResource m
  => H.Component HH.HTML Query Unit Void m
component =
  H.parentComponent
    { initialState: const { route: Home } 
    , render
    , eval
    , receiver: const Nothing
    }

  where 

  render :: State -> H.ParentHTML Query ChildQuery ChildSlot m
  render { route } = case route of
<<<<<<< HEAD
    Home -> HH.slot' CP.cp1 unit Home.component unit (const Nothing)
=======
    Home -> HH.div [ HE.onClick $ HE.input_ Click ] [ HH.text "click" ]
>>>>>>> master
    Login -> HH.div_ []
    Register -> HH.div_ []
    Settings -> HH.slot' CP.cp2 unit Settings.component unit (const Nothing)
    Editor -> HH.div_ []
    EditArticle _ -> HH.div_ []
    ViewArticle _ -> HH.div_ []
    Profile _ -> HH.div_ []
    Favorites _ -> HH.div_ []
  
  eval :: Query ~> H.ParentDSL State Query ChildQuery ChildSlot Void m
  eval = case _ of
<<<<<<< HEAD
=======
    Click a -> do
      res <- getTags
      logDebug $ show res
      pure a

>>>>>>> master
    Navigate dest a -> do
      { route } <- H.get 
      when (route /= dest) do
        H.modify_ _ { route = dest }
<<<<<<< HEAD
      pure a
=======
      pure a
>>>>>>> master
