# Attributes-Based-Access-Control-on-BigQuery-Analytics



# BigQuery Built-in Access Control: Role Based (https://cloud.google.com/bigquery/docs/access-control)

When an identity calls a Google Cloud API, BigQuery requires that the identity has the appropriate permissions to use the resource. You can grant permissions by granting roles to a user, a group, or a service account.

To grant access to a BigQuery resource, assign one or more roles to a user, group, or service account. You can grant access at the following BigQuery resource levels:

organization or Google Cloud project level
dataset level
table or view level

# Why Attribute-based access control (ABAC) (https://en.wikipedia.org/wiki/Attribute-based_access_control)
Historically, access control models have included mandatory access control (MAC), discretionary access control (DAC), and more recently role-based access control (RBAC). These access control models are user-centric and do not take into account additional parameters such as resource information, the relationship between the user (the requesting entity) and the resource, and dynamic information e.g. time of the day or user IP. ABAC tries to address this by defining access control based on attributes which describe the requesting entity (the user), the targeted object or resource, the desired action (view, edit, delete...), and environmental or contextual information. This is why access control is said to be attribute-based.

# Why Native?

BigQuery has many features to support ABAC, such as authorized view, policy tag (column level access control) and row access policy (row level). And luckily these features can coexist. Authorized view is the most flexible method to build ABAC.


