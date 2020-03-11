from PIL import Image
import imgcompare
import glob
from natsort import natsorted
import cv2

def dataset_process():
	image_list = []
	resized_images = []

	for filename in natsorted(glob.glob('/Users/aidanaketebay/Desktop/diploma/dataset/*.png')):
		#print(filename)
		img = Image.open(filename)
		image_list.append(img)

	for image in image_list:
		image = image.resize((500,500))
		image = image.convert("RGBA")
		resized_images.append(image)

	for(i,new) in enumerate(resized_images):
		new.save('{}{}{}'.format('/Users/aidanaketebay/Desktop/diploma/new_dataset/', i+1, '.png'))
	return resized_images
#dataset_process()
def query_process():
	image_list = []
	resized_images = []

	for filename in natsorted(glob.glob('/Users/aidanaketebay/Desktop/diploma/queries/*.png')):
		#print(filename)
		img = Image.open(filename)
		image_list.append(img)

	for image in image_list:
		image = image.resize((500,500))
		image = image.convert("RGBA")
		resized_images.append(image)

	for(i,new) in enumerate(resized_images):
		new.save('{}{}{}'.format('/Users/aidanaketebay/Desktop/diploma/queries/new', i+1, '.png'))	
#query_process()

def image_searcher(query_image):
	percentages = []

	for filename in natsorted(glob.glob('/Users/aidanaketebay/Desktop/diploma/new_dataset/*.png')):
		img = Image.open(filename)
		#is_same = imgcompare.is_equal(img, query_image, tolerance=20)
		percentage = imgcompare.image_diff_percent(img, query_image)
		#print(img.filename + "  "+  str(percentage))
		percentages.append(percentage)

	indeex = percentages.index(min(percentages))
	img = dataset_process()
	print(cv2.imshow(img[indeex].filename, "IM"))

image_searcher("/Users/aidanaketebay/Desktop/diploma/queries/new6.png")


