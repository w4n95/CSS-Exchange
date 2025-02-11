# Download Domain Check

**Description:**

In this check we validate if the `Download Domain` feature was configured or not. This feature was introduced to address `CVE-2021-1730`.

If the feature is enabled, we validate if the URL configured to download attachments, is not set to the same as the internal or external Outlook Web App (OWA) url.

`CVE-2021-1730` will not be addressed if the url configured to be used by the `Download Domain` feature points to the same url(s) which is/are used by OWA.

The `Download Domain` feature is available on Microsoft Exchange Server 2016 and Microsoft Exchange Server 2019.

**Included in HTML Report?**

Yes

**Additional resources:**

[How to configure the Download Domain feature (see FAQ section)](https://msrc.microsoft.com/update-guide/vulnerability/CVE-2021-1730)