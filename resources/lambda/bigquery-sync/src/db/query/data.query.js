const { query } = require("../db.js");

const getUsers = async (initialDate) => {
  return query(
    `
    SELECT
      id,
      email,
      username,
      first_name,
      last_name,
      status,
      is_blocked,
      created_at,
      updated_at,
      deleted_at
    FROM "user".users
    WHERE 1 = 1
      ${
        initialDate
          ? `AND (created_at > $1::timestamp OR updated_at > $1::timestamp)`
          : ""
      }
  `,
    initialDate ? [initialDate] : undefined
  );
};

const getOrganizations = async (initialDate) => {
  return query(
    `
    SELECT
      id,
      name,
      slug,
      created_at,
      deleted_at
    FROM tenant.tenant_organization
    WHERE 1 = 1
      ${
        initialDate
          ? `AND (created_at > $1::timestamp OR ( deleted_at IS NOT NULL AND deleted_at > $1::timestamp))`
          : ""
      }
  `,
    initialDate ? [initialDate] : undefined
  );
};

const getPractices = async (initialDate) => {
  return query(
    `
    SELECT
      id,
      name,
      slug,
      organization_id,
      created_at,
      deleted_at
    FROM tenant.tenant_unit
    WHERE 1 = 1
      ${
        initialDate
          ? `AND (created_at > $1::timestamp OR ( deleted_at IS NOT NULL AND deleted_at > $1::timestamp))`
          : ""
      }
  `,
    initialDate ? [initialDate] : undefined
  );
};

const getCaseCards = async (initialDate) => {
  return query(
    `
    SELECT
      cc.id,
      cc.code,
      cc.patient_id,
      cc.workflow_status,
      cc.workflow_id,
      cc.fast_track,
      COALESCE(cc.grafting, '{}'::text[]) AS grafting,
      cc.restoration_type,
      cc.preferred_laboratory,
      cc.needs_extraction,
      cc.surgical_guide,
      cc.surgical_kit,
      cc.surgeon_id,
      cc.surgery_date,
      cc.follow_up,
      cc.restore_date,
      cc.archived,
      cci.implants_count,
      cc.created_at,
      cc.updated_at,
      cc.deleted_at
    FROM "case".case_cards cc
    LEFT JOIN
      (
        SELECT
          cci.card_id,
          COUNT(*) AS implants_count
        FROM "case".case_card_implants cci
        GROUP BY cci.card_id
      ) cci ON cci.card_id = cc.id
    WHERE 1 = 1
      ${
        initialDate
          ? `AND (cc.created_at > $1::timestamp OR cc.updated_at > $1::timestamp)`
          : ""
      }
  `,
    initialDate ? [initialDate] : undefined
  );
};

const getCaseCardWorkflowTransitionLog = async (initialDate) => {
  return query(
    `
    SELECT
      cctl.id,
      cctl.organization_id,
      cctl.unit_id,
      cctl.entity_id,
      cctl.workflow_id,
      cctl.new_status,
      cctl.created_at
    FROM "audit".case_card_transition_logs cctl
    WHERE 1 = 1
    ${
      initialDate
        ? `AND (cctl.created_at > $1::timestamp)`
        : ""
    }
  `,
    initialDate ? [initialDate] : undefined
  );
};

const getRoles = async () => {
  return query(
    `
    SELECT
      id,
      "name",
      COALESCE(extends, '{}'::text[]) AS extends,
      permissions
      FROM auth.roles;
  `
  );
};

const getUsersRoles = async () => {
  return query(
    `
    SELECT
      id,
      user_id,
      role_id,
      created_at
    FROM "user".user_roles;
  `
  );
};

const getTenantUsersLinks = async () => {
  return query(
    `
    SELECT id, resource_id, organization_id, unit_id
      FROM tenant_link.tenant_link_users;
  `
  );
};

const getTenantRolesLinks = async () => {
  return query(
    `
    SELECT id, resource_id, organization_id, unit_id
      FROM tenant_link.tenant_link_roles;
  `
  );
};

const getTenantPatientsLinks = async () => {
  return query(
    `
    SELECT resource_id, organization_id, unit_id
      FROM tenant_link.tenant_link_patients;
  `
  );
};

const getTenantCaseCardsLinks = async () => {
  return query(
    `
    SELECT resource_id, organization_id, unit_id
      FROM tenant_link.tenant_link_case_cards;
  `
  );
};

const getTenantConfig = async () => {
  return query(
    `
    SELECT
      tc.id,
      tc.type,
      tc.resource,
      tc.name,
      tc.revision,
      tc.is_active,
      tc.data
    FROM "tenant".tenant_config tc
  `
  );
};

const getTenantConfigLinks = async () => {
  return query(
    `
    SELECT id, resource_id, organization_id, unit_id
      FROM tenant_link.tenant_link_config;
  `
  );
};

module.exports = {
  getUsers,
  getOrganizations,
  getPractices,
  getCaseCards,
  getCaseCardWorkflowTransitionLog,
  getTenantConfig,

  getRoles,
  getUsersRoles,

  getTenantUsersLinks,
  getTenantRolesLinks,
  getTenantPatientsLinks,
  getTenantCaseCardsLinks,
  getTenantConfigLinks,
};
