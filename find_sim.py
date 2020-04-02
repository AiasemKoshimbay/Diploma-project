import numpy as np
import cv2
from PIL import Image
import glob
import os

raw_directoryPath = '/home/Aiasem/mysite/media/media/'
proccessed_directoryPath = '/home/Aiasem/mysite/media/proccessed_images/'
query_image = '/home/Aiasem/mysite/media/query/new.jpg'


def glob_filetypes(root_dir, *patterns):
    return [path
            for pattern in patterns
            for path in glob.glob(os.path.join(root_dir, pattern))]

raw_directoryPath_Files = sorted(glob_filetypes(raw_directoryPath, "*.jpg", "*.jpeg", "*.png", "*.bmp", "*.gif"))
proccessed_directoryPath_Files = sorted(glob_filetypes(proccessed_directoryPath, "*.jpg", "*.jpeg", "*.png", "*.bmp", "*.gif"))


def check_for_duplicates():

  raw_files = []
  proccessed_files = []

  for filename in raw_directoryPath_Files:
    file = os.path.basename(filename)
    print(file)
    raw_files.append(file)


  if not proccessed_directoryPath_Files:
      res = raw_files
  else:
    for filename in proccessed_directoryPath_Files:
      file = os.path.basename(filename)
      proccessed_files.append(file)

  res = list(set(raw_files) - set(proccessed_files))


  return res


def dataset_process():

  non_proccessed_files = check_for_duplicates()

  image_list = []
  resized_images = []

  for filename in non_proccessed_files:
    img = Image.open(raw_directoryPath + filename)
    image_list.append(img)


  for image in image_list:
    image = image.resize((500,500))
    image = image.convert("RGB")
    resized_images.append(image)

  i = 0
  for(i,new) in enumerate(resized_images):
    new.save('{}{}'.format(proccessed_directoryPath, non_proccessed_files[i]))
  return resized_images


def query_process(imagepath):

    image = Image.open(open(imagepath,'rb'))
    image = image.resize((500,500))
    image = image.convert("RGB")

    return image


def sift_sim(img, path_b):
  orb = cv2.ORB_create()

  # get the images

  img_a = np.array(img) #convert to numpy array

  img_b = cv2.imread(path_b) #read dataset image
  img_b = cv2.cvtColor(img_b, cv2.COLOR_BGR2RGB)

  # find the keypoints and descriptors with SIFT
  kp_a, desc_a = orb.detectAndCompute(img_a, None)
  kp_b, desc_b = orb.detectAndCompute(img_b, None)

  # initialize the bruteforce matcher
  bf = cv2.BFMatcher(cv2.NORM_HAMMING, crossCheck=True)

  # match.distance is a float between {0:100} - lower means more similar
  matches = bf.match(desc_a, desc_b)
  similar_regions = [i for i in matches if i.distance < 59]
  if len(matches) == 0:
    return 0
  return len(similar_regions) / len(matches)


def calculation():
    result = ""
    img_a = query_process(query_image)

    percentages_sift = []

    files = []


    for filename in proccessed_directoryPath_Files:
        result_sift = sift_sim(img_a, filename)
        print(filename, "    ",result_sift)
        if(result_sift > 0.35):
            percentages_sift.append(result_sift)
            files.append(filename)
    #print(percentages_sift)



    if len(percentages_sift) != 0:
        indeex = percentages_sift.index(max(percentages_sift))
        result = files[indeex]
    else:
        result = ""

    return result


def main_func():
    dataset_process()
    print(calculation())



