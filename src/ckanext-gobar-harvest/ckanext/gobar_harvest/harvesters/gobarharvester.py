from ckanext.harvest.harvesters.ckanharvester import CKANHarvester

class GobarCKANHarvester(CKANHarvester):

    def info(self):
        info = super().info()
        print("INFO FROM GOBAR CKAN HARVESTER")
        print(info)
        return info

    def modify_package_dict(self, package_dict, harvest_object):

        # Set a default custom field

        package_dict['remote_harvest'] = True

        # Add tags
        package_dict['tags'].append({'name': 'sdi'})

        return package_dict