package test

import (
	"os"
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"
)

func TestMain(m *testing.M) {
	retCode := m.Run()

	os.Exit(retCode)
}

func TestIamElements(t *testing.T) {
	terraformOptions := &terraform.Options{
		TerraformDir: "../examples/basic",
	}
	defer terraform.Destroy(t, terraformOptions)
	terraform.InitAndApply(t, terraformOptions)

	users := terraform.OutputList(t, terraformOptions, "users")
	expected_users := []string{
		"foo",
		"bar",
	}
	assert.Equal(t, expected_users, users)

	userRoleNames := terraform.OutputList(t, terraformOptions, "user_role_names")
	expectedUserRoleNames := []string{
		"AccountAdministrator",
	}
	assert.Equal(t, expectedUserRoleNames, userRoleNames)
}
