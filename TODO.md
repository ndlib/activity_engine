# Development Phases

## Phase 1

We need basic activity reporting and collecting. At this point, we would add the registration to each of the appropriate methods.
An initial assumption is that activity logs will be stored in a different persistence engine than the objects in which there is activity.
That is to say Fedora Commons for the persisted objects, and an ActiveRecord database for the persisted objects.

### High Level Tasks

* Allow for the creation of an Activity against a persisted object
* Allow for collecting my activity
* Allow for collecting a persisted objects activity

## Phase 2

Allow for the registration of all activity observers on an application basis.