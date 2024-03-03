class EmergencyContact {
  String name;
  String phoneNumber;
  String email;
  Relationship relationship;

  EmergencyContact(this.name, this.phoneNumber, this.email, this.relationship);
}

enum Relationship {
  parent,
  guardian,
  spouse,
  child,
  sibling,
  friend,
  partner,
  assistant,
  manager,
  other
}